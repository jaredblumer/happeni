class AddRecurringEventFields < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :recurrence_type, :string, default: nil
    add_column :events, :recurrence_frequency, :integer, default: nil
    add_column :events, :custom_recurrence_frequency, :integer, default: nil
    add_column :events, :custom_recurrence_unit, :string, default: nil
    add_column :events, :ends_recurrence_unit, :string, default: nil
    add_column :events, :ends_recurrence_date, :datetime, default: nil
    add_column :events, :number_of_occurrences, :integer, default: nil
  end
end
