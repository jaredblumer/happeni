class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to settings_path, notice: "Settings updated successfully."
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:subscribed_to_email)
  end
end
