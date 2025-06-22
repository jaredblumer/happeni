class NoUpcomingEventsMailer < Devise::Mailer
  require "mailtrap"

  def email(user)
    mail = Mailtrap::Mail::FromTemplate.new(
      from: { email: "hello@happeni.com", name: "Happeni" },
      to: [
        { email: "#{user.email}" }
      ],
      reply_to: { email: "hello@happeni.com", name: "Happeni Support" },
      template_uuid: Rails.application.credentials.dig(:mailtrap, :no_upcoming_events_template_id),
      template_variables: {
        subject: "Happeni - No Upcoming Events - #{Date.today.strftime('%B %d, %Y')}",
        unsubscribe_token: user.unsubscribe_token
      },
    )

    client = Mailtrap::Client.new(api_key: Rails.application.credentials.dig(:mailtrap, :api_key))

    begin
      response = client.send(mail)
    rescue Exception => e
        puts e.message
    end
    puts "Email to #{user.email} - No Upcoming Events - Successful: #{response[:success]}"
  end
end
