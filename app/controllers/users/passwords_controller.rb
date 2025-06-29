class Users::PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    super
    flash[:login_alert] = "If your email exists in our system, you’ll get reset instructions shortly."
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name)
  end
end
