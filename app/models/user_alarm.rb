class UserAlarm < ApplicationRecord
  belongs_to :user
  belongs_to :alarm

  validates :user_id, presence: true
  validates :alarm_id, presence: true
end
