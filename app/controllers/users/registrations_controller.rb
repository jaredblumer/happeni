class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [ :create ]

  def after_inactive_sign_up_path_for(resource)
    flash[:login_alert] = "Thank you for signing up! " \
      "We've sent a confirmation email to your email address. " \
      "Please check your inbox (and spam folder, just in case) " \
      "to confirm your email address and activate your account."
    new_user_session_path
  end

  private

  def check_captcha
    # initialize resource before calling verify_recaptcha so error messages attach
    self.resource = resource_class.new(sign_up_params)

    unless verify_recaptcha(model: resource)
      resource.validate # ensure other Devise validations still show
      set_minimum_password_length
      respond_with_navigational(resource) do
        flash.discard(:recaptcha_error)
        render :new
      end
      return
    end
  end
end
