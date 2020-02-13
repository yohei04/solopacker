require 'rails_helper'

describe 'サインイン・サインアップ周り', type: :system do
  describe 'サインアップ機能' do
    before do
      # ユーザーAを作成しておく
      user_a = FactoryBot.create(:user, name: 'ユーザーA', user_name: 'ユーザーネームA', email: 'a@example.com')
    end
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
      it 'バリデーションが働く' do  # 3
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
      it 'ホームに遷移する' do
        expect(page).to have_content 'StaticPages#home'
      end
    end
  end
end
