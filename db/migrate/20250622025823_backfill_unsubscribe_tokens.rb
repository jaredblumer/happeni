class BackfillUnsubscribeTokens < ActiveRecord::Migration[7.2]
  def up
    User.find_each do |user|
      user.update_columns(unsubscribe_token: SecureRandom.urlsafe_base64(32)) if user.unsubscribe_token.blank?
    end
  end

  def down
  end
end
