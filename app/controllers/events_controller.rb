class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @upcoming_events = Event.visible_to(current_user).upcoming.order(date: :asc)
    @past_events = Event.visible_to(current_user).past.order(date: :desc)
  end

  def show
    @event = Event.find(params[:id])

    unless @event.visible_to?(current_user)
      redirect_to root_path, alert: "You don't have access to that event."
    end
  end

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :date, :location)
  end
end
