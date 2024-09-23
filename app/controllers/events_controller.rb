class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = current_user.events.where("start_date >= ?", Date.today).order(:start_date, :start_time)
    @past_events_exist = current_user.events.where("start_date < ?", Date.today).exists?
  end

  def past_events
    @events = current_user.events.where("start_date < ?", Date.today).order(start_date: :desc, start_time: :desc)
  end

  def show
  end

  def new
    @event = Event.new
    @event.name = params[:event][:name] if params[:event] && params[:event][:name].present?
    @event.start_time = Time.current.change(hour: 12, min: 0)
    @event.end_time = @event.start_time + 1.hour
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
    if @event.update(event_params)
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
    params.require(:event).permit(:user_id, :name, :start_date, :start_time, :end_time, :location, :all_day,
                                  :recurrence_type, :recurrence_frequency, :custom_recurrence_frequency,
                                  :custom_recurrence_unit, :ends_recurrence_unit, :ends_recurrence_date,
                                  :number_of_occurrences)
  end
end
