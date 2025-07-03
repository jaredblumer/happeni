class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
      .where("start_at >= ?", Time.zone.today.beginning_of_day)
      .order(:start_at)

    @past_events_exist = current_user.events
      .where("start_at < ?", Time.zone.today.beginning_of_day)
      .exists?
  end

  def past_events
    @events = current_user.events
      .where("start_at < ?", Time.zone.today.beginning_of_day)
      .order(start_at: :desc)
  end

  def show
  end

  def new
    @event = Event.new
    @event.name = params[:event][:name] if params[:event]&.dig(:name).present?
    @event.start_at = Time.zone.now.change(hour: 12, min: 0)
    @event.end_at = @event.start_at + 1.hour
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new
    end
  end

  def update
    @event.assign_attributes(event_params)

    if @event.save
      redirect_to events_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def set_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :user_id,
      :name,
      :location,
      :all_day,
      :start_at,
      :end_at
    )
  end
end
