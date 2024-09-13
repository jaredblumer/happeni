class AddSubscribedToEmailToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :subscribed_to_email, :boolean, default: false, null: false
  end
end
