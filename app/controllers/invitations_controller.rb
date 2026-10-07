class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :require_creator

  def create
    invitation = @event.invitations.build(invitee_id: params[:invitee_id])

    if invitation.save
      redirect_to @event, notice: "Invitation sent."
    else
      redirect_to @event, alert: "Could not send that invitation."
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def require_creator
    unless @event.creator == current_user
      redirect_to @event, alert: "Only the creator can invite people."
    end
  end
end
