require 'rails_helper'

describe 'Sign up•Sign in', type: :model do
  describe 'User validation' do
    let(:user) { FactoryBot.build(:user) }

    it 'is valid with full information' do
      expect(user).to be_valid
    end
    it 'is invalid without a name' do
      user.name = nil
      user.valid?
      expect(user.errors.messages[:name]).to include 'can\'t be blank'
    end
    it 'is invalid without a user_name' do
      user.user_name = nil
      user.valid?
      expect(user.errors.messages[:user_name]).to include 'can\'t be blank'
    end
    it 'is invalid without a email' do
      user.email = nil
      user.valid?
      expect(user.errors.messages[:email]).to include 'can\'t be blank'
    end
    it 'is invalid without a password' do
      user.password = nil
      user.valid?
      expect(user.errors.messages[:password]).to include 'can\'t be blank'
    end

    describe 'user_name' do
      context 'with more than 50 letters' do
        it 'should be invalid' do
          user.user_name = 'a' * 51
          expect(user).to be_invalid
        end
      end
      context 'with the same user_name' do
        let(:other_user) { FactoryBot.create(:user, name: 'ユーザーB', user_name: 'ユーザーネームB', email: 'b@example.com') }
        it 'should be invalid' do
          user.user_name = other_user.user_name
          expect(user).to be_invalid
        end
      end
    end

    describe 'email' do
      context 'with the same enail' do
        let(:other_user) { FactoryBot.create(:user, name: 'ユーザーB', user_name: 'ユーザーネームB', email: 'b@example.com') }
        it 'should be invalid' do
          user.email = other_user.email
          expect(user).to be_invalid
        end
      end
    end

    describe 'password' do
      context 'with more than 6 letters' do
        it 'should be valid' do
          user.password = 'a' * 6
          expect(user).to be_valid
        end
      end
      context 'with less than 5 letters' do
        it 'should be invalid' do
          user.password = 'a' * 5
          expect(user).to be_invalid
        end
      end
      context 'with the same password' do
        let(:other_user) { FactoryBot.create(:user, name: 'ユーザーB', user_name: 'ユーザーネームB', email: 'b@example.com') }
        it 'should be valid' do
          user.password = other_user.password
          expect(user).to be_valid
        end
      end
    end
  end
end
