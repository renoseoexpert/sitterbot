class KidsController < ApplicationController
  def new
    @kid = Kid.new
  end

  def create
    @kid = current_user.kids.new(kid_params)

    if @kid.save
      render json: @kid
    else
      render json: @kid.errors.full_messages, status: :unprocessable_entity
    end
  end

  def index
    @kids = current_user.kids
  end

  def edit
    @kid = current_user.kids.find(params[:id])
  end

  def show
    @kid = current_user.kids.find(params[:id])
  end

  private

  def kid_params
    params.require(:kid).permit(:nickname, :birthdate, :instructions)
  end
end
