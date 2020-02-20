require 'rails_helper'

describe 'Sign up•Sign in', type: :model do
  describe "User validation" do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'is valid with full information' do
      expect(@user).to be_valid
    end
    it 'is invalid without a name' do
      @user.name = nil
      @user.valid?
      expect(@user.errors.messages[:name]).to include 'can\'t be blank'
    end
    it 'is invalid without a email' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.messages[:email]).to include 'can\'t be blank'
    end
    
    describe 'password' do
      context 'with no letters' do
        it 'should be invalid' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.messages[:password]).to include 'can\'t be blank'
        end
      end
      context 'with more than 6 letters' do
        it 'should be valid' do
          # user = FactoryBot.build(:user, password: nil)
          @user.password = "a" * 6
          expect(@user).to be_valid
        end
      end
      context 'with less than 5 letters' do
        it 'should be invalid' do
          @user.password = "a" * 5
          expect(@user).to be_invalid
        end
      end
    end
  end
end
