class Event < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

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

  def time_range
    if all_day
      "All Day"
    else
      "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
    end
  end

  def as_json_for_email
    {
      "days_away" => days_away,
      "event_name" => name,
      "date" => start_date.strftime("%A, %B %d, %Y"),
      "time" => time_range,
      "location" => location
    }
  end
end
