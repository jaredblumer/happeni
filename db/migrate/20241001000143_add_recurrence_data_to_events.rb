class AddRecurrenceDataToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :recurrence_data, :jsonb
  end
end
