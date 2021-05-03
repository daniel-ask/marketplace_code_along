require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user){ 
    described_class.new(
      email: 'test@test.com',
      password: 'password',
      username: 'testuser'
    )
   }

   it 'is valid with valid attributes' do
    expect(user).to be_valid
   end

   describe 'validations' do
    it 'should be invalid without a username' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'should be invalid without a email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'should be invalid without a password' do
      user.password = nil
      expect(user).to_not be_valid
    end

    it 'should be invalid with a password shorter than 6 characters' do
      user.password = '1'
      expect(user).to_not be_valid
    end

    it 'should be invalid with an email in the wrong format' do
      user.email = 'test'
      expect(user).to_not be_valid
    end

    it 'should check that username has only alphanumeric characters' do
      user.username = 'd@$()'
      expect(user).to_not be_valid
    end

    it 'should check that username has no spaces' do
      user.username = 'd ok'
      expect(user).to_not be_valid
    end

    it 'should check that emails are unique' do
      should validate_uniqueness_of(:email).ignoring_case_sensitivity
    end

    it 'should check that username is unique' do
      should validate_uniqueness_of(:username)
    end
   end

   describe 'associations' do
    it 'should have many listings' do
      relation = User.reflect_on_association(:listings)
      expect(relation.macro).to eql(:has_many)
    end
   end
end
