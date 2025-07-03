class User < ApplicationRecord
  before_validation :ensure_unsubscribe_token
  validates :unsubscribe_token, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :events, dependent: :destroy

  def has_upcoming_events?
    events.where("start_at >= ?", Date.today.beginning_of_day).exists?
  end

  def no_upcoming_events?
    !has_upcoming_events?
  end

  def upcoming_events
    events
      .where("start_at >= ?", Date.today.beginning_of_day)
      .order(:start_at)
      .limit(5)
  end

  private

  def ensure_unsubscribe_token
    self.unsubscribe_token ||= SecureRandom.urlsafe_base64(32)
  end
end
