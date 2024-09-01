class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @events = current_user.events.order(:start_date, :start_time)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = current_user.events.build(event_params)
    clear_times_if_all_day
    if @event.save
      redirect_to events_path, notice: "Event was successfully created."
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "Event was successfully deleted."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event was successfully deleted."
  end

  private

  def set_event
    @event = current_user.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:user_id, :name, :start_date, :start_time, :end_time, :location)
  end

  def clear_times_if_all_day
    if @event.all_day?
      @event.start_time = nil
      @event.end_time = nil
    end
  end
end
