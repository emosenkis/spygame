class GamesController < ApplicationController
  before_filter :signed_in_user
  before_filter :user_playing_game, only: :update_position
  def index
    @games = Game.paginate(page: params[:page])
  end
  def show
    @game = Game.find(params[:id])
  end
  def new
    @game = Game.new
  end
  def create
    @game = Game.new(params[:game])
    if @game.save
      flash[:success] = "Game created!"
      redirect_to @game
    else
      render 'new'
    end
  end
  def join
    @game = Game.find(params[:id])
    @player = @game.players.new(@current_user)
    if @player.save
      redirect_to @game
    else
      redirect_to @game
    end
  end
  def update_position
    
  end

  private

    def user_playing_game
      @game = current_user.games.first
      if @game.nil?
        render json: {goto: games_url}
      end
    end
end
