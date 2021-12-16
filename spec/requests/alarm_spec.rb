require 'rails_helper'

RSpec.describe 'Alarms', type: :request do
  include ActiveJob::TestHelper

  describe 'GET /alarms' do
    before :each do
      @alarm_params = {
        'user_ids' => [1],
        'title' => 'sidekiq testing',
        'time' => '00:00:01'
      }
    end

    context 'alarms' do
      context 'create on /new route' do
        it 'has title and time' do
          create(:user, id: 1)
          post '/api/v1/alarms/new', params: {
            user_ids: [1],
            title: 'title',
            time: '00:00:01'
          }
          expect(response.status).to(be_between(200, 300))
        end
        it 'has missing title and time' do
          create(:user, id: 1)
          expect {
            post '/api/v1/alarms/new', params: {
              user_ids: [1],
              title: nil,
              time: '00:00:01'
            }
          }.to raise_error(ActiveRecord::RecordInvalid)
          expect {
            post '/api/v1/alarms/new', params: {
              user_ids: [1],
              title: 'title',
              time: nil
            }
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      it 'Return list of alarms' do
        create(:alarm)
        create(:alarm)
        create(:alarm)

        get '/api/v1/alarms/'
        expect(JSON.parse(response.body).size).to(eq(3))
      end

      # how to test scheduled jobs?
      it 'creates a new alarm' do
        user = create(:user, id: 1)
        AlarmScheduler::V1::Helpers::Alarms.new.schedule(@alarm_params)
        expect(user.notifications.count).to(eq(1))
      end
    end
  end
end
