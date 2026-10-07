class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendances, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :attendances
  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations

  validates :title, :date, :location, presence: true

  scope :past, -> { where("events.date < ?", Time.current) }
  scope :upcoming, -> { where("events.date >= ?", Time.current) }
  scope :visible_to, ->(user) {
    if user
      where(
        "events.is_private = ? OR events.creator_id = ? OR events.id IN (?)",
        false,
        user.id,
        Invitation.where(invitee_id: user.id).select(:event_id)
      )
    else
      where(is_private: false)
    end
  }

  def visible_to?(user)
    return true unless is_private?
    return false if user.nil?

    creator_id == user.id || invitees.exists?(user.id)
  end
end
