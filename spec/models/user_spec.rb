require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:events) }
  end

  describe "devise modules" do
    it "validates email presence and format" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "requires a password" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end

  describe "#has_upcoming_events?" do
    let(:user) { create(:user) }

    context "when the user has no events" do
      it "returns false" do
        expect(user.has_upcoming_events?).to be false
      end
    end

    context "when the user has only past events" do
      before do
        create(:event, user: user, start_date: Date.yesterday)
      end

      it "returns false" do
        expect(user.has_upcoming_events?).to be false
      end
    end

    context "when the user has future events" do
      before do
        create(:event, user: user, start_date: Date.tomorrow)
      end

      it "returns true" do
        expect(user.has_upcoming_events?).to be true
      end
    end
  end

  describe "#no_upcoming_events?" do
    let(:user) { create(:user) }

    it "returns the inverse of #has_upcoming_events?" do
      expect(user.no_upcoming_events?).to eq(!user.has_upcoming_events?)
    end
  end

  describe "#upcoming_events" do
    let(:user) { create(:user) }

    before do
      create(:event, user: user, name: "Past", start_date: Date.yesterday)
      create(:event, user: user, name: "All Day Event", start_date: Date.today + 1, all_day: true)
      create(:event, user: user, name: "Morning Event", start_date: Date.today + 1, start_time: "09:00", all_day: false)
      create(:event, user: user, name: "Evening Event", start_date: Date.today + 1, start_time: "18:00", all_day: false)
    end

    it "returns only upcoming events ordered by start_date, all_day first, then start_time" do
      results = user.upcoming_events.map(&:name)
      expect(results).to eq([ "All Day Event", "Morning Event", "Evening Event" ])
      expect(results).not_to include("Past")
    end

    it "limits the results to 5 events" do
      create_list(:event, 10, user: user, start_date: Date.today + 2.days)
      expect(user.upcoming_events.count).to be <= 5
    end
  end
end
