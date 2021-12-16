module AlarmScheduler
  module V1
    class Users < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :users do
        desc 'Return list of user'
        get do
          present User.all
        end

        resource :new do
          params do
            requires :name
            optional :cntr, default: 0, type: Integer
          end

          post do
            User.create(params)
          end
        end

        route_param :id do
          desc 'Return user by id'
          get do
            @user = User.find_by_id(params[:id])
            present user: @user, notifications: @user.notifications
          end
        end
      end
    end
  end
end
