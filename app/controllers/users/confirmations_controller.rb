class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    confirmation_token = params[:confirmation_token]
    self.resource = resource_class.find_by_confirmation_token(confirmation_token)

    if !confirmation_token || resource.nil?
      flash[:confirmation_alert] = "Invalid confirmation token. Enter your email below to receive a new confirmation email."
      redirect_to new_user_confirmation_path
    elsif resource.confirmed?
      flash[:login_alert] = "Your account has already been activated. Please sign in to continue."
      redirect_to new_user_session_path
    elsif resource.confirm
      flash[:login_alert] = "Your account has been activated. Please sign in to continue."
      redirect_to new_user_session_path
    end
  end
end
