class SittersController < ApplicationController
  def new
    @sitter = Sitter.new
  end

  def edit
    @sitter = current_user.sitters.find(params[:id])
  end

  def index
    @sitters = current_user.sitters
  end

  def create
    @sitter = current_user.sitters.new(sitter_params)

    if @sitter.save
      render json: @sitter
    else
      render json: @sitter.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @sitter = current_user.sitters.find(params[:id])
  end

  private

  def sitter_params
    params
      .require(:sitter)
      .permit(
        :paid,
        :hourly_rate,
        :phone,
        :email,
        :name,
        :can_drive,
        :per_extra_kid
      )
  end
end
