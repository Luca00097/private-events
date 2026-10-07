class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :invitee, class_name: "User"

  validates :invitee_id, uniqueness: { scope: :event_id }
end
