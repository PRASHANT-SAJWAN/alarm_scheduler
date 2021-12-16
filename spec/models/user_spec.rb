require 'rails_helper'

RSpec.describe User, type: :model do
  context 'model validation' do
    context 'name' do
      it 'is not present' do
        user = build(:user, name: nil)
        expect(user.valid?).to(eq(false))
      end
      it 'is present' do
        user = build(:user, name: 'prashant')
        expect(user.valid?).to(eq(true))
      end
    end
  end
end
