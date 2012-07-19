class GamesController < ApplicationController

  before_filter :signed_in_user
  before_filter :user_in_game, only: [:update_position, :briefing, :start, :leave, :main]
  before_filter :game_state_is_playing, only: [:briefing, :main, :update_position]
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
    main
  end
  def main
     spy=@game.players.find_by_role('spy')
     detectives=@game.players.where(role: 'detective')
     data={
       id: @game.id,
       user_id: @current_user.id,
       role: @player.role,
       detectives: detectives.collect do |player|
         position=player.latest_position
         {
           user_id: player.user_id,
           latitude: position.latitude,
           longitude: position.longitude,
           name: player.user.name
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

  private

    def user_in_game
      @game = current_user.game_states.find(params[:id])
      if @game.nil?
        render json: {goto: 'games'}, callback: params[:callback]
      end
      @player=@game.players.find_by_user_id(@current_user.id)
    end
    def game_state_is_playing
      if @game.state != 'playing'
        render json: {goto: 'game'}, callback: params[:callback]
      end
    end
end
