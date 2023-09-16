require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'saves successfully with good values' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to be_valid
      expect(user.save).to be true
    end
  end
end