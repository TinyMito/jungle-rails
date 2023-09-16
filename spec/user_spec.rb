require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'user registers successfully with good values' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123pass123',
        password_confirmation: 'pass123pass123'
        )
      expect(user).to be_valid
      expect(user.save).to be true
    end

    it 'is not valid the password is not the same' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123pass123',
        password_confirmation: 'notthesamepassword'
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
        password_confirmation: 'pass123pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Password can't be blank", "Password can't be blank", "Password is too short (minimum is 10 characters)"]
    end

    it 'is not valid first name is missing' do
      user = User.new(
        first_name: nil, 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123pass123',
        password_confirmation: 'pass123pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["First name can't be blank"]
    end

    it 'is not valid last name is missing' do
      user = User.new(
        first_name: "FirstName", 
        last_name: nil, 
        email: "test@test.com", 
        password: 'pass123pass123',
        password_confirmation: 'pass123pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it 'is not valid email is missing' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: nil, 
        password: 'pass123pass123',
        password_confirmation: 'pass123pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email can't be blank"]
    end

    it 'is not valid email is duplicated' do
      User.create!(
        first_name: "FirstName2", 
        last_name: "LastName2", 
        email: "TEST@TEST.com", 
        password: 'pass321pass321',
        password_confirmation: 'pass321pass321'
      )
      user = User.new(
        first_name: "FirstName1", 
        last_name: "LastName1", 
        email: "test@test.com", 
        password: 'pass123pass123',
        password_confirmation: 'pass123pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Email has already been taken"]
    end

    it 'is not valid password did not meet length requirement of 10' do
      user = User.new(
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'pass123',
        password_confirmation: 'pass123'
        )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq ["Password is too short (minimum is 10 characters)"]
    end
  end

  describe '.authenticate_with_credentials' do
    let(:session_params) do
      {
        first_name: "FirstName", 
        last_name: "LastName", 
        email: "test@test.com", 
        password: 'myultimatepassword123',
        password_confirmation: 'myultimatepassword123'
      }
    end

    before do
      User.create!(session_params)
    end

    it 'is able to login successfully' do
      auth = User.authenticate_with_credentials('test@test.com','myultimatepassword123')
      expect(auth).to be_an_instance_of(User)
    end

    it 'is not able to login with wrong password' do
      auth = User.authenticate_with_credentials('test@test.com','wrongpassword')
      expect(auth).to be_nil
    end

    it 'is not able to login with wrong email' do
      auth = User.authenticate_with_credentials('test@TEST.com','myultimatepassword123')
      expect(auth).to be_nil
    end

    it 'is not able to login with extra space in email' do
      auth = User.authenticate_with_credentials(' test@test.com ','myultimatepassword123')
      expect(auth).to be_nil
    end
  end
end