class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    attendance = current_user.attendances.build(attended_event: event)

    if attendance.save
      redirect_to event, notice: "You're attending this event."
    else
      redirect_to event, alert: "Could not save your attendance."
    end
  end
end
