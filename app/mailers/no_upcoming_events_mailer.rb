class NoUpcomingEventsMailer < Devise::Mailer
  require "sendgrid-ruby"
  include SendGrid

  def send_email(user)
    data = {
      "personalizations": [
        {
          "to": [
            {
              "email": "#{user.email}"
            }
          ],
          "dynamic_template_data": {
            "subject": "Happeni - Upcoming Events - #{Date.today.strftime('%B %d, %Y')}"
          }
        }
      ],
      "from": {
        "email": "hello@happeni.com"
      },
      "template_id": Rails.application.credentials.dig(:sendgrid, :no_upcoming_events_template_id)
    }.to_json
    sg = SendGrid::API.new(api_key: Rails.application.credentials.dig(:sendgrid, :api_key))
    begin
        response = sg.client.mail._("send").post(request_body: data)
    rescue Exception => e
        puts e.message
    end
    puts "Email to #{user.email} - Status Code: #{response.status_code}"
  end
end
