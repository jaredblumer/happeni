ActionMailer::Base.smtp_settings = {
  user_name: "apikey",
  password: Rails.application.credentials.dig(:sendgrid, :api_key),
  domain: "happeni.com",
  address: "smtp.sendgrid.net",
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
