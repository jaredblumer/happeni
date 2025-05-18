require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "#days_away" do
    let(:event) { build(:event, start_date: start_date) }

    context "when the event is today" do
      let(:start_date) { Date.today }

      it "returns 'Today!'" do
        expect(event.days_away).to eq("Today!")
      end
    end

    context "when the event is in the future" do
      let(:start_date) { Date.today + 2.days }

      it "returns days away in future tense" do
        expect(event.days_away).to eq("2 Days Away")
      end
    end

    context "when the event is in the past" do
      let(:start_date) { Date.today - 1.day }

      it "returns days ago in past tense" do
        expect(event.days_away).to eq("1 Day Ago")
      end
    end
  end

  describe "#date_time" do
    context "when event is all day" do
      it "returns only the formatted date" do
        event = build(:event, all_day: true, start_date: Date.new(2025, 5, 20))
        expect(event.date_time).to eq("Tuesday, May 20, 2025")
      end
    end

    context "when event is not all day" do
      it "returns full date with time range" do
        event = build(:event,
                      all_day: false,
                      start_date: Date.new(2025, 5, 20),
                      start_time: Time.zone.parse("10:00 AM"),
                      end_time: Time.zone.parse("12:00 PM"))

        expect(event.date_time).to eq("Tuesday, May 20, 2025 | 10:00 AM - 12:00 PM")
      end
    end
  end
end
