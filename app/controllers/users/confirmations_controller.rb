class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])

    if resource.nil?
      # Handle invalid confirmation token
      flash[:alert] = "Invalid confirmation token. Enter your email below to receive a new confirmation email."
      redirect_to new_user_confirmation_path
    elsif resource.confirmed?
      # Redirect if already confirmed
      flash[:notice] = "Your account has been activated. Please sign in to continue."
      redirect_to new_user_session_path
    else
      # Proceed with default confirmation logic
      resource.confirm
      set_flash_message!(:notice, :confirmed)
      respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    end
  end

  def after_confirmation_path_for(resource_name, resource)
    new_user_session_path
  end
end
