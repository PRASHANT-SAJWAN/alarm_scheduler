require 'rails_helper'

RSpec.describe Alarm, type: :model do
  context 'model validation' do
    context 'title' do
      it 'is not present' do
        alarm = build(:alarm, title: nil)
        expect(alarm.valid?).to(eq(false))
      end
      it 'is present' do
        alarm = build(:alarm, title: 'Title')
        expect(alarm.valid?).to(eq(true))
      end
    end

    context 'time' do
      it 'is not present' do
        alarm = build(:alarm, time: nil)
        expect(alarm.valid?).to(eq(false))
      end
      it 'is present' do
        alarm = build(:alarm, time: '00:00:01')
        expect(alarm.valid?).to(eq(true))
      end
    end
  end
end
