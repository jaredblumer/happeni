class ConvertEventDateAndTimeToDatetime < ActiveRecord::Migration[7.2]
  def up
    add_column :events, :start_at, :datetime
    add_column :events, :end_at, :datetime

    Event.reset_column_information
    Event.find_each do |event|
      if event.start_date.present? && event.start_time.present?
        event.update_columns(
          start_at: DateTime.new(
            event.start_date.year,
            event.start_date.month,
            event.start_date.day,
            event.start_time.hour,
            event.start_time.min
          )
        )
      elsif event.start_date.present?
        event.update_columns(
          start_at: event.start_date.to_datetime
        )
      end

      if event.start_date.present? && event.end_time.present?
        event.update_columns(
          end_at: DateTime.new(
            event.start_date.year,
            event.start_date.month,
            event.start_date.day,
            event.end_time.hour,
            event.end_time.min
          )
        )
      end
    end

    remove_column :events, :start_date
    remove_column :events, :start_time
    remove_column :events, :end_time
  end

  def down
    add_column :events, :start_date, :date
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time

    Event.reset_column_information
    Event.find_each do |event|
      if event.start_at.present?
        event.update_columns(
          start_date: event.start_at.to_date,
          start_time: event.start_at.to_time
        )
      end

      if event.end_at.present?
        event.update_columns(
          end_time: event.end_at.to_time
        )
      end
    end

    remove_column :events, :start_at
    remove_column :events, :end_at
  end
end
