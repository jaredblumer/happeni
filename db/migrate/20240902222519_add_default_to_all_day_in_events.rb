class AddDefaultToAllDayInEvents < ActiveRecord::Migration[7.2]
  def change
    change_column_default :events, :all_day, from: nil, to: false
  end
end
