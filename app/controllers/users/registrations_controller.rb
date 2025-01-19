class Users::RegistrationsController < Devise::RegistrationsController
  def after_inactive_sign_up_path_for(resource)
    flash[:notice] = "Thank you for signing up! " +
      "We've sent a confirmation email to your email address. " +
      "Please check your inbox (and spam folder, just in case) " +
      "to confirm your email address and activate your account."
    new_user_session_path
  end
end
