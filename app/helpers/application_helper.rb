module ApplicationHelper
  def days_away_message(event)
    days_away = (event.start_date - Date.today).to_i

    if days_away > 0
      "#{pluralize(days_away, 'Day')} Away"
    elsif days_away == 0
      "Today!"
    else
      "#{pluralize(days_away.abs, 'Day')} Ago"
    end
  end
end
