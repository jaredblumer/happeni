class RenameEventOptionsToEventIdeas < ActiveRecord::Migration[7.2]
  def up
    # Rename event_options to event_ideas if the table exists
    if table_exists?(:event_options)
      rename_table :event_options, :event_ideas
    end
  end

  def down
    # Rename event_ideas back to event_options if the table exists
    if table_exists?(:event_ideas)
      rename_table :event_ideas, :event_options
    end
  end
end