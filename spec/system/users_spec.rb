require 'rails_helper'

describe 'ユーザー登録・認証周り', type: :system do
  let!(:user_a) { FactoryBot.create(:user, name: 'userA', user_name: 'user_nameA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.build(:user, name: 'userB', user_name: 'user_nameB', email: 'b@example.com') }
  describe 'サインアップ機能' do
    before do
      visit new_user_registration_path
      fill_in 'Name', with: signup_user.name
      fill_in 'User name', with: signup_user.user_name
      fill_in 'Email', with: signup_user.email
      fill_in 'Password', with: signup_user.password
      fill_in 'Confirm Password', with: signup_user.password
      click_on 'Sign up'
    end
    context 'userAでサインアップしたとき' do
      let(:signup_user) { user_a }
      it 'カラムの一意性に失敗してバリデーションが働く' do
        expect(page).to have_content 'has already been taken'
      end
    end
    context 'userBでサインアップしたとき' do
      let(:signup_user) { user_b }
      it '成功してホームに遷移する' do
        expect(page).to have_link href: root_path, count: 2
        expect(page).to have_link 'Let\'s Get Started', href: new_user_registration_path
        expect(page).to have_selector '.flash__notice', text: 'signed up successfully.'
        expect(page).to_not have_link 'Sign in', href: new_user_session_path
      end
    end
  end
  describe 'サインイン機能' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: signin_user.email
      fill_in 'Password', with: signin_user.password
      click_button 'Sign in'
    end
    context 'userAでサインインしたとき' do
      let(:signin_user) { user_a }
      it '成功してホームに遷移する' do
        expect(page).to have_link href: root_path, count: 2
        expect(page).to have_link 'Let\'s Get Started', href: new_user_registration_path
        expect(page).to have_selector '.flash__notice', text: 'Signed in successfully.'
        expect(page).to_not have_link 'Sign in', href: new_user_session_path
      end
    end
  end
  describe 'サインアウト機能' do
    context 'ユーザーがサインアウトしたとき' do
      it 'サインインページに遷移する' do
        login_as user_a
        visit root_path
        find('.dropdown-toggle').click
        click_on 'Sign out'
        expect(page).to have_link 'Sign in', href: new_user_session_path
        expect(page).to have_selector '.flash__notice', text: 'Signed out successfully.'
      end
    end
  end
  describe 'プロフィール登録' do
    before do
      login_as user_a
      visit root_path
      find('.dropdown-toggle').click
      click_on 'Profile'
    end
    context 'ユーザーがプロフィールを更新したとき' do
      it 'Saveするとデータが更新されてホームに遷移する' do
        expect(page).to have_content 'Date Of Birth'
        expect(page).to have_content 'Language①'
        select 'China', from: 'Hometown:'
        fill_in 'user_name', with: 'hogehoge'
        fill_in 'user_language_1', with: 'Chinese'
        click_on 'Save'
        user_a.reload
        expect(current_path).to eq(root_path)
        expect(page).to have_selector '.flash__notice', text: 'Save profile successfully.'
        expect(user_a.origin).to eq 'CN'
        expect(user_a.name).to eq 'hogehoge'
        expect(user_a.language_1).to eq 'Chinese'
      end
      it 'サインアップ時と同じようにバリデーションが働く' do
        fill_in 'Name:', with: ''
        fill_in 'User Name:', with: 'a' * 16
        click_on 'Save'
        expect(page).to have_content 'can\'t be blank'
        expect(page).to have_content 'too long'
      end
    end
  end
  describe 'User/Profile' do
    let!(:users) { FactoryBot.create_list(:user, 10) }
    context 'when visit User/Profile#index page' do
      it 'has user list and pagination' do
        login_as user_a
        visit users_profiles_path
        expect(page).to have_content 'Members'
        expect(page).to have_selector 'img'
        expect(page).to have_selector '.user_name', text: user_a.user_name
        expect(page).to have_selector '.user_name', text: users[1].user_name
        expect(page).to have_selector '.age'
        expect(page).to have_selector '.gender'
        expect(page).to have_selector '.origin_country'
        expect(page).to have_selector '.current_country'
        expect(page).to have_selector '.pagination'
        expect(page).to have_selector('.user_name', count: 5)
        click_on '2'
        expect(page).to have_selector '.user_name', text: users[6].user_name
      end
    end
    context 'when visit User/Profile#show page' do
      it 'has user detail' do
        login_as user_a
        visit users_profile_path(user_a)
        expect(page).to have_selector 'img'
        expect(page).to have_selector '.user_name', text: user_a.user_name
        expect(page).to have_selector('.country_flag', count: 2)
        expect(page).to have_selector '.language_1', text: user_a.language_1
        expect(page).to have_selector '.introduce', text: user_a.introduce
      end
    end
    context 'when visit User/Profile#index & #show page without sign in' do
      it 'is returned to Sign in page' do
        visit users_profiles_path
        expect(page).to have_link 'Sign in', href: new_user_session_path
        visit users_profile_path(user_a)
        expect(page).to have_link 'Sign in', href: new_user_session_path
      end
    end
  end
end
