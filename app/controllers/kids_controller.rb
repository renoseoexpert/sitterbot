class KidsController < ApplicationController
  def new
    @kid = Kid.new
  end

  def create
    @kid = current_user.kids.new(kid_params)

    if @kid.save
      redirect_to kids_path
    else
      flash.now[:errors] = @kid.errors.full_messages
      render :new
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

  def destroy
    @kid = current_user.kids.find(params[:id])
    @kid.try(:destroy)
    redirect_to :back
  end

  private

  def kid_params
    params.require(:kid).permit(:nickname, :birthdate, :instructions)
  end
end
