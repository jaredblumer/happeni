class DeleteRecurrenceFrequencyFromEvents < ActiveRecord::Migration[7.2]
  def change
    remove_column :events, :recurrence_frequency, :integer
  end
end
