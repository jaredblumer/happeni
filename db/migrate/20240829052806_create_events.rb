class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.string :location

      t.timestamps
    end
  end
end
