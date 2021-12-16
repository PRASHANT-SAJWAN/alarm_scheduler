require 'sidekiq/api'
# schedule alarms
class AlarmSchedulerWorker
  include Sidekiq::Worker

  def perform(user_ids, title)
    cur_time = Time.now
    user_ids.each do |cur_user_id|
      # create a notificaiton with current time
      # having user_id and alarm title
      Notification.create!(
        user_id: cur_user_id,
        title: title,
        time: cur_time
      )
    end
  end
end
