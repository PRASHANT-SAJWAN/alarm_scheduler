require 'rails_helper'

RSpec.describe "Alarms", type: :request do
  include ActiveJob::TestHelper

  describe "GET /alarms" do
    before :each do
      @alarm_params = {
        'user_ids' => [1],
        'title' => 'sidekiq testing',
        'time' => '00:00:01'
      }
    end

    context 'alarms' do
      it 'Return list of alarms' do
        create(:alarm)
        create(:alarm)
        create(:alarm)

        get '/api/v1/alarms/'
        expect(response.status).to(eq(200))
        expect(JSON.parse(response.body).size).to(eq(3))
      end

      # how to test scheduled jobs?
      it 'creates a new alarm' do
        # ActiveJob::Base.queue_adapter = :test
        # ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

        user = create(:user, id: 1)
        AlarmScheduler::V1::Helpers::Alarms.new.schedule(@alarm_params)
        byebug
        # This line is goint to execute the backgound job
        perform_enqueued_jobs
        # Models reload with new data
        user.reload
        byebug
        expect(user.notifications.count).to(eq(1))

      end
    end
  end
end
