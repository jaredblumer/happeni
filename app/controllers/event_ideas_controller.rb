class EventIdeasController < ApplicationController
  def index
    @event_ideas = EventIdea.all.sample(4)
  end
end