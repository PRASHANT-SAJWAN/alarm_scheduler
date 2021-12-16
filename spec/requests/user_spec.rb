require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before :each do
      @user_params = {
        name: 'testuser'
      }
    end

    context 'create users' do
      it 'has missing name field' do
        post '/api/v1/users/new', params: { id: 0, name: nil }
        expect(response.status).not_to(eq(200))
      end
    end

    context 'get users' do
      it 'Return list of user' do
        create(:user, id: 1)
        create(:user, id: 2)
        create(:user, id: 3)
        create(:user, id: 4)

        get '/api/v1/users/'
        expect(response.status).to(eq(200))
        expect(JSON.parse(response.body).size).to(eq(4))
        expect(User.all.count).to(eq(4))
      end

      it 'return user by id' do
        user = create(:user, id: 1)
        get "/api/v1/users/#{user.id}"
        expect(response.status).to(eq(200))
        expect(JSON.parse(response.body)['user']['id']).to(eq(user.id))
      end
    end

    it 'on user delete' do
      create(:user, id: 1)
      create(:alarm, id: 1)
      create(:user_alarm, user_id: 1, alarm_id: 1)

      expect(UserAlarm.all.count).to(eq(1))
      User.first.destroy
      expect(UserAlarm.all.count).to(eq(0))
    end
  end
end
