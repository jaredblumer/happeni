class UpcomingEventsMailer < Devise::Mailer
  require "mailtrap"

  def email(user)
    mail = Mailtrap::Mail::FromTemplate.new(
      from: { email: "hello@happeni.com", name: "Happeni" },
      to: [
        { email: "#{user.email}" }
      ],
      reply_to: { email: "hello@happeni.com", name: "Happeni Support" },
      template_uuid: Rails.application.credentials.dig(:mailtrap, :upcoming_events_template_id),
      template_variables: {
        events: generate_event_data(user),
        subject: "Happeni - Upcoming Events - #{Date.today.strftime('%B %d, %Y')}"
      },
    )

    client = Mailtrap::Client.new(api_key: Rails.application.credentials.dig(:mailtrap, :api_key))

    begin
      response = client.send(mail)
    rescue Exception => e
        puts e.message
    end
    puts "Email to #{user.email} - Upcoming Events - Successful: #{response[:success]}"
  end

  private

  def generate_event_data(user)
    user.upcoming_events.map do |event|
      {
        "name": event.name,
        "days_away": event.days_away,
        "date_time": event.date_time
      }
    end
  end
end
