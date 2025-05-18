require 'rails_helper'

RSpec.describe "Settings", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /settings" do
    it "renders the settings page successfully" do
      get settings_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Settings") # Adjust based on your view
    end
  end

  describe "PATCH /settings" do
    context "with valid parameters" do
      it "updates the user's subscription setting" do
        patch settings_path, params: {
          user: { subscribed_to_email: true }
        }

        expect(response).to redirect_to(settings_path)
        follow_redirect!
        expect(response.body).to include("Settings updated successfully.")
        expect(user.reload.subscribed_to_email).to be true
      end
    end

    context "with invalid parameters" do
      it "re-renders the settings page" do
        allow_any_instance_of(User).to receive(:update).and_return(false)

        patch settings_path, params: {
          user: { subscribed_to_email: true }
        }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Settings") # Assuming view re-renders
      end
    end
  end
end
