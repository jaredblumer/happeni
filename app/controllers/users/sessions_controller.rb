class Users::SessionsController < Devise::SessionsController
  prepend_before_action :check_captcha, only: [ :create ]
  before_action :check_user_confirmation, only: :create

  private

  def check_user_confirmation
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      unless user.confirmed?
        flash[:login_alert] = "Your account is not yet activated. Please check your email for the confirmation link, or request a new one below."
        redirect_to new_user_confirmation_path and return
      end
    else
      flash[:login_alert] = "Invalid email or password."
    end
  end

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_in_params

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      return render :new
    end
  end
end
