class GamesController < ApplicationController
  include GameHelper

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
      game_start
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
     data={
       id: @game.id,
       user_id: @current_user.id,
       role: @player.role
     }
     data.merge! game_data
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
      end
      if @game.state != 'playing'
        render json: {goto: @game.state == 'over' ? 'debriefing' : 'gameLobby', gameId: @game.id}, callback: params[:callback]
      end
    end
end
