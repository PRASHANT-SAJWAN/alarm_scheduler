class Alarm < ApplicationRecord
  has_many :user_alarms, dependent: :destroy
  has_many :users, through: :user_alarms

  validates :title, presence: true
  validates :time, presence: true
end
