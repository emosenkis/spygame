class GamesController < ApplicationController

  before_filter :signed_in_user
  before_filter :user_in_game, only: [:update_position, :briefing, :start, :leave, :main, :outcome, :debriefing]
  before_filter :game_state_is_playing, only: [:briefing, :main, :update_position]
  before_filter :game_state_is_over, only: [:debriefing]
  def index
    games = GameState.order('created_at DESC').paginate(page: params[:page]).collect do |game|
      {
        id: game.id,
        state: game.state,
        players: game.players.collect {|p| p.user.name}
      }
    end
    render json: games, callback: params[:callback]
  end
  def show
    game = GameState.find(params[:id])
    data = {
      id: game.id,
      state: game.state,
      players: game.players.collect {|p| p.user.name},
      in_game: !!game.players.find_by_user_id(@current_user.id)
    }
    render json: data, callback: params[:callback]
  end
  def create
    game = GameState.new()
    game.state = 'pending'
    game.save
    game.players.create(user_id: @current_user.id)
    render json: {goto: 'gameLobby', gameId: game.id}, callback: params[:callback]
  end
  def join
    game = GameState.find(params[:id])
    if game.state == 'pending' && !game.players.find_by_user_id(@current_user.id)
      player = game.players.new(user_id: @current_user.id)
      player.save
    end
    render json: {goto: 'gameLobby', gameId: game.id}, callback: params[:callback]
  end
  def start
    if @game.state == 'pending'
      @game.date_time_of_start = Time.now
      @game.state = 'playing'
      @game.save
      players=@game.players
      spy=players[Random.rand(players.count)]
      players.each do |player|
        player.role = player.id == spy.id ? 'spy' : 'detective'
        player.save
      end
    end
    render json: {goto: 'briefing', gameId: @game.id}, callback: params[:callback]
  end
  def briefing
    main
  end
  def leave
    game = GameState.find(params[:id])
    player = game.players.find_by_user_id(@current_user.id)
    if player
      player.destroy
      if game.players.empty?
        game.destroy
      end
    end
    render json: {goto: 'games'}, callback: params[:callback]
  end
  def update_position
    if !!params[:latitude] && !!params[:longitude]
      @player.update_position(params[:latitude], params[:longitude])
    end
  
    main if @game.state == 'playing'
  end
  def main
     spy=@game.players.find_by_role('spy')
     detectives=@game.players.where(role: 'detective')
     data={
       id: @game.id,
       countdown: [0, @game.date_time_of_start + @game.length - Time.now].max,
       user_id: @current_user.id,
       role: @player.role,
       detectives: detectives.collect do |player|
         position=player.latest_position
         {
           user_id: player.user_id,
           latitude: position.latitude,
           longitude: position.longitude,
           name: player.user.name,
           dist_to_spy: distance_to(player, spy) > -1  ? distance_to(player, spy) : 'unknown'
         }
       end
     }
     if spy
       position=spy.latest_position(@game.spy_update_time(60))
       data[:spy]={
         user_id: spy.user_id,
         latitude: position.latitude,
         longitude: position.longitude,
         name: spy.user.name
       }
     end
     render json: data, callback: params[:callback]
  end
  def debriefing
    render json: {
      id: @game.id,
      role: @player.role,
      outcome: @game.data
    }, callback: params[:callback]
  end


  private
    # Returns distance between two players in feet
    def distance_to (player1, player2)
      if(player1.latest_position.latitude.nil? or player2.latest_position.latitude.nil?) then
        return -1
      else
        position1=player1.latest_position
        position2=player2.latest_position
        lat1 = position1.latitude
        lon1 = position1.longitude
        lat2 = position2.latitude
        lon2 = position2.longitude
        GeoPoint.coord_mode = :lng_lat
        p1, p2 = [[lon1, lat1].geo_point, [lon2, lat2].geo_point]
        dist = GeoDistance::Haversine.geo_distance(p1, p2).to_miles
        #dist = GeoDistance::Haversine.geo_distance(lat1, lon1, lat2, lon2).to_miles

        #dist = 100
        dist.feet
      end

    end

    def user_in_game
      @game = current_user.game_states.find(params[:id])
      if @game.nil?
        render json: {goto: 'games'}, callback: params[:callback]
      end
      @player=@game.players.find_by_user_id(@current_user.id)
    end

    def game_state_is_over
      if @game.state != 'over'
        render json: {goto: 'gameLobby', gameId: @game.id}, callback: params[:callback]
      end
    end

    def game_state_is_playing
      if @game.state == 'playing' && (Time.now - @game.date_time_of_start) >= @game.length
        @game.state = 'over'
        @game.data = 'escape'
        @game.save
      else
        #Test spy's proximity to all detectives (20 foot range)
        spy=@game.players.find_by_role('spy')
        detectives=@game.players.where(role: 'detective')
        if detectives.detect {|detective| distance_to(detective, spy) < 20 and 
            distance_to(detective, spy) > -1} then
          @game.state = 'over'
          @game.data = 'caught'
          @game.save
        end
      end


      if @game.state != 'playing'
        render json: {goto: @game.state == 'over' ? 'debriefing' : 'gameLobby', gameId: @game.id}, callback: params[:callback]
      end
    end
end
