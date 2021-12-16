require 'sidekiq/api'
# wrapping Alarm functionality
module AlarmScheduler
  module V1
    # Helper for params validation
    module SharedParams
      extend Grape::API::Helpers

      params :schedule do
        requires :time, type: String
        requires :title, type: String
        requires :user_ids, type: Array[Integer]
      end
    end

    # for scheduling alarms
    class Alarms < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api
      helpers SharedParams

      resource :alarms do
        desc 'Return list of alarms'
        get do
          present Alarm.all
        end

        # @time: string with time in HH-MM-SS format
        # @title: string
        # @users: integer array containing user_ids
        resource :new do
          desc 'creates a new alarm'
          params do
            use :schedule
          end
          post do
            # @user_ids => Integer_array
            # @time => 'HH-MM-SS' format string
            # @title => string
            Helpers::Alarms.new.schedule(params)
          end
        end

        resource :delete do
          route_param :id do
            desc 'delete this alarm'
            get do
              @alarm = Alarm.find(params[:id])
              user_ids = @alarm.user_alarms.all.pluck(:user_id)

              # delete sidekiq scheduled alarms
              ss = Sidekiq::ScheduledSet.new
              ss.each do |job|
                # array check
                job.delete if job.args.first == user_ids
              end
              Alarm.delete(params[:id])
            end
          end
        end
      end
    end
  end
end
