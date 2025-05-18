require 'rails_helper'

RSpec.describe EventIdeasController, type: :controller do
  describe "GET #index" do
    before do
      create_list(:event_idea, 4)
    end

    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    it "assigns up to 4 event ideas" do
      get :index
      expect(assigns(:event_ideas).length).to be <= 4
      expect(assigns(:event_ideas)).to all(be_a(EventIdea))
    end
  end
end
