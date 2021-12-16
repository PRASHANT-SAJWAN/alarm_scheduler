class User < ApplicationRecord
  has_many :user_alarms, dependent: :destroy
  has_many :alarms, through: :user_alarms

  validates :name, presence: true

  def notifications
    # fetch all notifications of this user
    Notification.where(user_id: id)
  end
end
