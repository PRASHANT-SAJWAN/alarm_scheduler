module AlarmScheduler
  module V1
    module Helpers
      # Helper for alarm.rb
      class Alarms
        # @user_ids => Integer_array
        # @time => 'HH-MM-SS' format string
        # @title => string
        def schedule(params)
          time = params['time'].split(':')
          time = time[0].to_i * 3600 + time[1].to_i * 60 + time[2].to_i
          # create alarm
          Alarm.transaction do
            UserAlarm.transaction do
              @alarm = Alarm.create(
                title: params['title'],
                time: Time.now + time.seconds
              )
              params['user_ids'].each do |cur_user_id|
                UserAlarm.create!(
                  alarm_id: @alarm.id,
                  user_id: cur_user_id
                )
              end
            end
          end
          # update user after 'time' seconds
          AlarmSchedulerWorker.perform_in(time.seconds, params['user_ids'], @alarm.title)
          byebug
        end
      end
    end
  end
end
