require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { create(:user) }
  let!(:upcoming_event) { create(:event, user: user, start_date: Date.today + 1.day) }
  let!(:past_event) { create(:event, user: user, start_date: Date.today - 1.day) }

  before { sign_in user }

  describe "GET /events" do
    it "shows only upcoming events" do
      get events_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(upcoming_event.name)
      expect(response.body).not_to include(past_event.name)
    end
  end

  describe "GET /events/past_events" do
    it "shows only past events" do
      get past_events_events_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(past_event.name)
      expect(response.body).not_to include(upcoming_event.name)
    end
  end

  describe "GET /events/new" do
    it "renders the new event form with default times" do
      get new_event_path
      expect(response).to have_http_status(:ok)
      expect(assigns(:event).start_time.hour).to eq(12)
    end

    it "pre-fills event name if passed in params" do
      get new_event_path, params: { event: { name: "Test Event" } }
      expect(assigns(:event).name).to eq("Test Event")
    end
  end

  describe "POST /events" do
    it "creates a valid event" do
      expect {
        post events_path, params: {
          event: attributes_for(:event)
        }
      }.to change(Event, :count).by(1)
      expect(response).to redirect_to(events_path)
    end

    it "re-renders form with invalid data" do
      expect {
        post events_path, params: {
          event: attributes_for(:event, name: nil)
        }
      }.not_to change(Event, :count)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("error")
    end
  end

  describe "PATCH /events/:id" do
    it "updates an event" do
      patch event_path(upcoming_event), params: {
        event: { name: "Updated Name" }
      }
      expect(response).to redirect_to(events_path)
      expect(upcoming_event.reload.name).to eq("Updated Name")
    end

    it "re-renders form with invalid data" do
      patch event_path(upcoming_event), params: {
        event: { name: "" }
      }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("error")
    end
  end

  describe "DELETE /events/:id" do
    it "deletes an event" do
      event = create(:event, user: user)
      expect {
        delete event_path(event)
      }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(events_path)
    end
  end
end
