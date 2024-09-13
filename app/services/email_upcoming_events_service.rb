class EmailUpcomingEventsService
  def initialize
    @postmark_service = PostmarkEmailService.new
  end

  def send_upcoming_event_emails
    users_subscribed_to_email = User.where(subscribed_to_email: true)

    users_subscribed_to_email.each do |user|
      upcoming_events = user.events.where("start_date >= ?", Date.today).order(start_date: :asc, start_time: :asc)

      template_model_events = generate_template_model_events(upcoming_events)

      if upcoming_events.any?
        send_upcoming_events_email(to: user.email, template_model_events:)
      else
        send_no_upcoming_events_email(to: user.email)
      end
    end
  end

  private

  def generate_template_model_events(upcoming_events)
    upcoming_events.map(&:as_json_for_email)
  end

  def send_upcoming_events_email(to:, template_model_events:)
    @postmark_service.client.deliver_with_template(
      from: "hello@happeni.com",
      to: to,
      template_id: ENV["UPCOMING_EVENTS_TEMPLATE_ID"],
      template_model: {
        "events": template_model_events
      })
  end

  def send_no_upcoming_events_email(to:)
    @postmark_service.client.deliver_with_template(
      from: "hello@happeni.com",
      to: to,
      template_id: ENV["NO_UPCOMING_EVENTS_TEMPLATE_ID"],
      template_model: {}
    )
  end
end
