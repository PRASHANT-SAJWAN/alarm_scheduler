module AlarmScheduler
  class Base < Grape::API
    mount AlarmScheduler::V1::Users
    mount AlarmScheduler::V1::Alarms
  end
end
