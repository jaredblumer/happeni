class Event < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  before_validation :adjust_for_all_day

  def days_away
    days_diff = (start_at.to_date - Time.zone.today).to_i
    if days_diff > 0
      "#{days_diff} Day#{'s' if days_diff > 1} Away"
    elsif days_diff == 0
      "Today!"
    else
      "#{days_diff.abs} Day#{'s' if days_diff.abs > 1} Ago"
    end
  end

  def date_time
    if all_day
      start_at.strftime("%A, %B %d, %Y")
    else
      "#{start_at.strftime('%A, %B %d, %Y')} | #{start_at.strftime('%I:%M %p')} - #{end_at.strftime('%I:%M %p')}"
    end
  end

  private

  def adjust_for_all_day
    return unless all_day && start_at.present?
    self.start_at = start_at.beginning_of_day
    self.end_at   = start_at.end_of_day
  end
end
