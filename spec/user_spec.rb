require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'registers successfully with good values' do
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

    it 'is not valid the password is not the same' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass321'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
    end

    it 'is not valid password is missing' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: nil,
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Password can't be blank"]
    end

    it 'is not valid first name is missing' do
      user = User.new(
        first_name: nil, 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it 'is not valid last name is missing' do
      user = User.new(
        first_name: "FirstName", 
        last_name: nil, 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it 'is not valid email is missing' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: nil, 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it 'is not valid email is duplicated' do
      User.create!(
        first_name: "FirstName2", 
        last_name: "LastName2", 
        email: "TEST@TEST.com", 
        password: 'pass321',
        password_confirmation: 'pass321'
      )
      user = User.new(
        first_name: "FirstName1", 
        last_name: "LastName1", 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email has already been taken"]
    end
  end
end