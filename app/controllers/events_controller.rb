class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

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

    default_start = Time.zone.now.change(hour: 12, min: 0)
    default_end = default_start + 1.hour

    @event.start_date = default_start.to_date
    @event.start_time = default_start.strftime("%H:%M")
    @event.end_date   = default_end.to_date
    @event.end_time   = default_end.strftime("%H:%M")
  end

  def edit
    @event.start_date = @event.start_at&.to_date
    @event.start_time = @event.start_at&.strftime("%H:%M")
    @event.end_date   = @event.end_at&.to_date
    @event.end_time   = @event.end_at&.strftime("%H:%M")
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
      :name,
      :all_day,
      :start_date,
      :start_time,
      :end_date,
      :end_time
    )
  end
end
