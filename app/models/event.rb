class Event < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  attr_accessor :start_date, :start_time, :end_time

  before_validation :combine_datetime_fields
  before_validation :adjust_for_all_day

  def days_away
    days_diff = (start_at.to_date - Time.zone.today).to_i
    if days_diff > 0
      "#{days_diff} Day#{'s' if days_diff > 1} Away"
    elsif days_diff == 0
      "Today!"
    else
      "#{days_diff.abs} Day#{'s' if days_diff.abs > 1} Ago"
    end
  end

  def date_time
    if all_day
      start_at.strftime("%A, %B %d, %Y")
    else
      "#{start_at.strftime('%A, %B %d, %Y')} | #{start_at.strftime('%I:%M %p')} - #{end_at.strftime('%I:%M %p')}"
    end
  end

  def start_date
    @start_date || start_at&.to_date
  end

  def start_time
    @start_time || start_at&.strftime("%H:%M")
  end

  def end_date
    @end_date || end_at&.to_date
  end

  def end_time
    @end_time || end_at&.strftime("%H:%M")
  end

  def start_date=(val)
    @start_date = val
  end

  def start_time=(val)
    @start_time = val
  end

  def end_date=(val)
    @end_date = val
  end

  def end_time=(val)
    @end_time = val
  end

  private

  def combine_datetime_fields
    if @start_date.present? && @start_time.present?
      self.start_at = Time.zone.parse("#{@start_date} #{@start_time}")
    end

    if @end_date.present? && @end_time.present?
      self.end_at = Time.zone.parse("#{@end_date} #{@end_time}")
    end
  end

  def adjust_for_all_day
    return unless all_day && start_at.present?

    self.start_at = start_at.beginning_of_day
    self.end_at   = start_at.end_of_day
  end
end
