require 'rails_helper'

describe 'ユーザー登録・認証周り', type: :system do
  before do
    # ユーザーAを作成しておく
    @userA = FactoryBot.create(:user, name: 'ユーザーA', user_name: 'ユーザーネームA', email: 'a@example.com')
  end
  describe 'サインアップ機能' do
    context 'ユーザーAでサインアップしたとき' do
      before do
        visit new_user_registration_path
        fill_in 'Name', with: 'ユーザーA'
        fill_in 'User name', with: 'ユーザーネームA'
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm Password', with: 'password'
        click_button 'Sign up'
      end
      it '失敗してバリデーションが働く' do
        expect(page).to have_content 'error'
      end
    end
    context 'ユーザーBでサインアップしたとき' do
      before do
        visit new_user_registration_path
        fill_in 'Name', with: 'ユーザーB'
        fill_in 'User name', with: 'ユーザーネームB'
        fill_in 'Email', with: 'b@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm Password', with: 'password'
        click_button 'Sign up'
      end
      it '成功してホームに遷移する' do
        expect(page).to have_link href: root_path, count: 2
        expect(page).to have_link 'Let\'s Get Started', href: new_user_registration_path
        expect(page).to have_selector '.flash__notice', text: 'signed up successfully.'
        expect(page).to_not have_link 'Sign in', href: new_user_session_path
      end
    end
  end
  describe 'サインイン機能' do
    context 'ユーザーAでサインインしたとき' do
      before do
        visit new_user_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Sign in'
      end
      it '成功してホームに遷移する' do
        expect(page).to have_link href: root_path, count: 2
        expect(page).to have_link 'Let\'s Get Started', href: new_user_registration_path
        expect(page).to have_selector '.flash__notice', text: 'Signed in successfully.'
        expect(page).to_not have_link 'Sign in', href: new_user_session_path
      end
    end
  end
end
