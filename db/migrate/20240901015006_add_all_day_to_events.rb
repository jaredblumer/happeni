class AddAllDayToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :all_day, :boolean
  end
end
