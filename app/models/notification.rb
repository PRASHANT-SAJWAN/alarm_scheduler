class Notification < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: true
  validates :time, presence: true
end
