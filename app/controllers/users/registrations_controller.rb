class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [ :create ]

  def after_inactive_sign_up_path_for(resource)
    flash[:alert] = "Thank you for signing up! " +
      "We've sent a confirmation email to your email address. " +
      "Please check your inbox (and spam folder, just in case) " +
      "to confirm your email address and activate your account."
    new_user_session_path
  end

  private

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate # Look for any other validation errors besides reCAPTCHA
    set_minimum_password_length

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      render :new
    end
  end
end
