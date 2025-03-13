class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :events

  def has_upcoming_events?
    events.where("start_date >= ?", Date.today.beginning_of_day).exists?
  end

  def no_upcoming_events?
    !has_upcoming_events?
  end

  def upcoming_events
    events.where("start_date >= ?", Date.today.beginning_of_day)
          .order(:start_date, Arel.sql("CASE WHEN all_day THEN 0 ELSE 1 END"), :start_time)
          .limit(5)
  end
end
