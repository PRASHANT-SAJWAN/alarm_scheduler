require 'rails_helper'

RSpec.describe UserAlarm, type: :model do
  context 'model validation' do
    context 'user_id' do
      it 'is not present' do
        user_alarm = build(:user_alarm, user_id: nil)

        expect(user_alarm.valid?).to(eq(false))
      end
      it 'is not integer' do
        user_alarm = build(:user_alarm, user_id: 'string')

        expect(user_alarm.valid?).to(eq(false))
      end
    end

    context 'alarm_id' do
      it 'is not present' do
        user_alarm = build(:user_alarm, alarm_id: nil)
        expect(user_alarm.valid?).to(eq(false))
      end
      it 'is not integer' do
        user_alarm = build(:user_alarm, alarm_id: 'string')
        expect(user_alarm.valid?).to(eq(false))
      end
    end

    it 'user_id and alarm_id is present && is integer' do
      @user = User.create(name: 'user')
      @alarm = Alarm.create(title: 'title', time: '00:00:05')
      user_alarm = build(:user_alarm, user_id: @user.id, alarm_id: @alarm.id)

      expect(user_alarm.valid?).to(eq(true))
    end
  end
end
