class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendances, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :attendances
  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations

  validates :title, :date, :location, presence: true

  scope :past, -> { where("events.date < ?", Time.current) }
  scope :upcoming, -> { where("events.date >= ?", Time.current) }
end
