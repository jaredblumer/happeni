class RemoveRecurrenceFieldsFromEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :custom_recurrence_frequency, :integer
    remove_column :events, :custom_recurrence_unit, :string
    remove_column :events, :ends_recurrence_unit, :string
    remove_column :events, :ends_recurrence_date, :datetime
    remove_column :events, :number_of_occurrences, :integer
    remove_column :events, :recurrence_type, :string
    remove_column :events, :recurrence_data, :jsonb
  end
end
