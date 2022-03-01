# frozen_string_literal: true
class Event < ApplicationRecord
  require "date"
  validates :name, :description, :event_date, presence: true
  validates :name, length: { minimum: 2, maximum: 50 }
  validates :description, length: { minimum: 10, maximum: 300 }
  validates :event_date, comparison: { greater_than: Date.today, message: "can't be in past" }
  belongs_to :user
  has_many :enrollments
  has_many :enroll_events, through: :enrollments, source: :user
end
