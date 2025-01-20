class Users::SessionsController < Devise::SessionsController
  before_action :check_user_confirmation, only: :create

  def create
    super
  end

  private

  def check_user_confirmation
    user = User.find_by(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      unless user.confirmed?
        flash[:alert] = "Your account is not yet activated. Please check your email for the confirmation link, or request a new one below."
        redirect_to new_user_confirmation_path
      end
    else
      flash[:alert] = "Invalid email or password."
    end
  end
end
