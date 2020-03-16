require 'rails_helper'

describe 'Recruit pages', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:recruit) { FactoryBot.create(:recruit) }
  describe 'GET #new' do
    context 'when user signed in' do
      it 'returns http success' do
        login_as user
        get new_recruit_path
        expect(response).to have_http_status '200'
        expect(response.body).to include 'Create'
      end
    end
    context 'when user not signed in' do
      it 'redirects to the sign in page' do
        get new_recruit_path
        expect(response).to redirect_to user_session_path
      end
    end
    context 'when user not filled in gender' do
      it 'redirects to the profile page' do
        login_as user
        user.gender = nil
        get new_recruit_path
        expect(response).to redirect_to edit_users_profile_path(user)
      end
    end
    context 'when user not filled in origin' do
      it 'redirects to the profile page' do
        login_as user
        user.origin = nil
        get new_recruit_path
        expect(response).to redirect_to edit_users_profile_path(user)
      end
    end
    context 'when user not filled in current_country' do
      it 'redirects to the profile page' do
        login_as user
        user.current_country = nil
        get new_recruit_path
        expect(response).to redirect_to edit_users_profile_path(user)
      end
    end
    context 'when user not filled in language_1' do
      it 'redirects to the profile page' do
        login_as user
        user.language_1 = nil
        get new_recruit_path
        expect(response).to redirect_to edit_users_profile_path(user)
      end
    end
    context 'when user not filled in introduce' do
      it 'redirects to the profile page' do
        login_as user
        user.introduce = nil
        get new_recruit_path
        expect(response).to redirect_to edit_users_profile_path(user)
      end
    end
  end
  describe 'POST #create' do
    before do
      login_as user
    end
    context 'with correct parameters' do
      it 'is successfully created' do
        post recruits_path, params: { recruit: FactoryBot.attributes_for(:recruit) }
        expect(response.status).to eq 302
        expect(response).to redirect_to Recruit.last
      end
    end
    context 'with not correct parameters' do
      it 'shows error page' do
        post recruits_path, params: { recruit: FactoryBot.attributes_for(:recruit, title: nil) }
        expect(response.body).to include 'error'
      end
    end
  end
  describe 'Get #edit' do
    context 'when user signed in' do
      before do
        login_as user
        get edit_recruit_path(recruit)
      end
      it 'returns http success' do
        expect(response).to have_http_status '200'
      end
      it "shows header'edit'" do
        expect(response.body).to include 'Edit'
      end
    end
    context 'when user not signed in' do
      it 'redirects to the sign in page' do
        get edit_recruit_path(recruit)
        expect(response).to redirect_to user_session_path
      end
    end
  end
  describe 'PATCH #update' do
    before do
      login_as user
    end
    context 'with correct parameters' do
      it 'is successfully updated' do
        patch recruit_path(recruit), params: { recruit: { id: recruit.id } }
        expect(response.status).to eq 302
        recruit.title = 'test'
        expect(response).to redirect_to Recruit.find_by(title: 'test')
      end
    end
    context 'with incorrect parameters' do
      it 'shows error page' do
        patch recruit_path(recruit), params: { recruit: { title: '' } }
        expect(response.body).to include 'error'
      end
    end
  end
  describe 'GET #index' do
    context 'when user signed in' do
      before do
        login_as user
        get root_path
      end
      it 'returns http success' do
        expect(response).to have_http_status '200'
      end
      it "shows 'when' and 'where'" do
        expect(response.body).to include 'when'
        expect(response.body).to include 'where'
      end
    end
    context 'when user not signed in' do
      it 'shows unsigned in home page' do
        get root_path
        expect(response.body).to include 'About'
      end
    end
  end
  describe 'GET #show' do
    context 'when user signed in' do
      it 'returns http success' do
        login_as user
        get recruit_path(recruit)
        expect(response).to have_http_status '200'
        expect(response.body).to include 'when'
        expect(response.body).to include recruit.title
        expect(response.body).to include recruit.hour.to_s
        expect(response.body).to include recruit.user.user_name
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'delete a recruit' do
      it 'is successfully deleted' do
        login_as user
        expect do
          delete recruit_path(recruit)
        end.to change(Recruit, :count).by(-1)
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.body).to include 'flash__notice'
      end
    end
  end
end
