class GamesController < ApplicationController

  before_filter :signed_in_user
  before_filter :user_in_game, only: [:update_position, :briefing, :start, :leave]
  before_filter :user_playing_game, only: [:update_position, :briefing, :main]
  before_filter :force_mobile_format
  def index
    @games = GameState.paginate(page: params[:page])
  end
  def show
    @game = GameState.find(params[:id])
    @in_game = !!@game.players.find_by_user_id(@current_user.id)
  end
  def create
    @game = GameState.new()
    @game.date_time_of_start = Time.now
    @game.state = 'pending'
    @game.save!
    redirect_to join_game_path(@game)
  end
  def join
    game = GameState.find(params[:id])
    if game.state == 'pending' && !game.players.find_by_user_id(@current_user.id)
      @player = game.players.new(user_id: @current_user.id)
      @player.save!
    end
    redirect_to game
  end
  def start
    if @game.state == 'pending'
      @game.state = 'playing'
      @game.save
      players=@game.players
      spy=players[Random.rand(players.count)]
      players.each do |player|
        player.role = player.id == spy.id ? 'spy' : 'detective'
        player.save
      end
    end
    redirect_to game_briefing_path(@game)
  end
  def briefing
    @player=@game.players.find_by_user_id(@current_user.id)
  end
  def main
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
    redirect_to games_path
  end
  def update_position
     player=@game.players.find_by_user_id(@current_user.id)
     player.latitude=params[:latitude]
     player.longitude=params[:longitude]
     player.save
     spy=@game.players.find_by_role('spy')
     detectives=@game.players.where(role: 'detective')
     data={
       detectives: detectives.collect do |player|
         {
           user_id: player.user_id,
           latitude: player.latitude,
           longitude: player.longitude,
           name: player.user.name
         }
       end,
       your_id: @current_user.id
     }
     if spy
       data[:spy]={
         user_id: spy.user_id,
         latitude: spy.latitude,
         longitude: spy.longitude,
         name: spy.user.name
       }
     end
     render json: data
  end

  private

    def user_in_game
      @game = current_user.game_states.first
      if @game.nil?
        redirect_to games_path
      end
    end
    def user_playing_game
      if @game.state != 'playing'
        render json: {goto: games_url}
      end
    end
end
