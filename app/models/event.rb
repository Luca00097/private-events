class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendances, foreign_key: "attended_event_id", dependent: :destroy
  has_many :attendees, through: :attendances

  validates :title, :date, :location, presence: true

  def self.past
    where("events.date < ?", Time.current)
  end

  def self.upcoming
    where("events.date >= ?", Time.current)
  end
end
