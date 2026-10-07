class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])

    unless event.visible_to?(current_user)
      return redirect_to root_path, alert: "You don't have access to that event."
    end

    attendance = current_user.attendances.build(attended_event: event)

    if attendance.save
      redirect_to event, notice: "You're attending this event."
    else
      redirect_to event, alert: "Could not save your attendance."
    end
  end
end
