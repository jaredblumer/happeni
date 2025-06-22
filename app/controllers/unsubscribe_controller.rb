class UnsubscribeController < ApplicationController
  before_action :find_user_by_token, except: [ :success, :error, :resubscribe_success ]

  def show
    if @user.subscribed_to_email?
      render :confirm
    else
      render :already_unsubscribed
    end
  end

  def confirm
    if @user.update(subscribed_to_email: false)
      redirect_to unsubscribe_success_path
    else
      flash[:alert] = "Sorry, we couldn’t unsubscribe you. Please try again."
      redirect_to unsubscribe_path(@user.unsubscribe_token)
    end
  end

  def success
    # Renders unsubscribe/success.html.erb
  end

  def resubscribe
    if @user.update(subscribed_to_email: true)
      redirect_to resubscribe_success_path
    else
      flash[:alert] = "We couldn’t resubscribe you. Please try again later."
      redirect_to unsubscribe_path(@user.unsubscribe_token)
    end
  end

  def resubscribe_success
    # Renders unsubscribe/resubscribe_success.html.erb
  end

  def error
    # Renders unsubscribe/error.html.erb
  end

  private

  def find_user_by_token
    @user = User.find_by(unsubscribe_token: params[:token])

    unless @user
      redirect_to unsubscribe_error_path
    end
  end
end
