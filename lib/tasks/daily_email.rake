namespace :emails do
  desc "Send SendGrid upcoming event emails"
  task send_event_emails: :environment do
    send_emails_to_users_with_upcoming_events
    send_emails_to_users_without_upcoming_events
  end

  def send_emails_to_users_with_upcoming_events
    users_with_events = User.where(subscribed_to_email: true).select do |user|
      user.has_upcoming_events?
    end

    users_with_events.each do |user|
      UpcomingEventsMailer.email(user).deliver_now
    end

    puts "Sent emails for #{users_with_events.count} users with upcoming events."
  end

  def send_emails_to_users_without_upcoming_events
    users_without_events = User.where(subscribed_to_email: true).select do |user|
      user.no_upcoming_events?
    end

    users_without_events.each do |user|
      NoUpcomingEventsMailer.email(user).deliver_now
    end

    puts "Sent emails for #{users_without_events.count} users without upcoming events."
  end
end
