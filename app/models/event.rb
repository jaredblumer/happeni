class Event < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  before_save :sanitize_recurrence_details

  def days_away
    days_diff = (start_date - Date.today).to_i
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
      start_date.strftime("%A, %B %d, %Y")
    else
      "#{start_date.strftime('%A, %B %d, %Y')} | #{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
    end
  end

  def sanitize_recurrence_details
    case recurrence_type
    when "Does Not Repeat", "Daily", "Weekly", "Monthly", "Yearly"
      self.custom_recurrence_frequency = nil
      self.custom_recurrence_unit = nil
      self.ends_recurrence_unit = nil
      self.ends_recurrence_date = nil
      self.number_of_occurrences = nil
    end
  end
end
