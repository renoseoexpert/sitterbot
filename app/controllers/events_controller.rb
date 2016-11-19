class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = current_user.events
  end

  def show
    @event = current_user.events.find(params[:id])
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to events_path
    else
      flash.now[:errors] = @event.errors.full_messages
      render :new
    end
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:food_included, :starts_at, :ends_at, :key, :flat_rate)
  end
end
