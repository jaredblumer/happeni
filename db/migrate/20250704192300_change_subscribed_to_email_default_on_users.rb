class ChangeSubscribedToEmailDefaultOnUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :subscribed_to_email, from: false, to: true
  end
end
