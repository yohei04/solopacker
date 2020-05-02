require 'rails_helper'

describe 'Participation', type: :request do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:recruit_a) { FactoryBot.create(:recruit) }
  let!(:comment_a) { FactoryBot.create(:comment, user: user_a, recruit: recruit_a) }

  describe 'POST #create' do
    context "when user didn't join yet" do
      it 'is successfully created' do
        login_as user_a
        get recruit_path(recruit_a)
        expect(response.body).to include "(#{recruit_a.participations.count})"
        expect(response.body).to include "I will Join"
        expect(response.body).not_to include user_a.user_name
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation), xhr: true
        end.to change(Participation, :count).by(1)
        expect(response.status).to eq 200
        expect(response.body).to include "changed my mind"
        expect(response.body).to include user_a.user_name
        expect(response.body).to include 'You joined this recruit!'
      end
    end
    context 'when user already has joined' do
      let!(:user_b) { FactoryBot.create(:user) }
      let!(:comment_a) { FactoryBot.create(:comment, user: user_b, recruit: recruit_a) }
      let!(:participation_a) { FactoryBot.create(:participation, user: user_a, recruit: recruit_a) }
      it "can't join again" do
        login_as user_a
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation), xhr: true
        end.to change(Participation, :count).by(0)
        expect(response.status).to eq 200
      end
      it 'is successfully joined by other user' do
        login_as user_b
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation), xhr: true
        end.to change(Participation, :count).by(1)
        expect(response.status).to eq 200
      end
      it 'has links to joined users' do
        get users_profile_path(user_a)
        expect(response.status).to eq 302
      end
    end
    context "when user didn't comment yet" do
      let!(:user_c) { FactoryBot.create(:user) }
      it "can't join" do
        login_as user_c
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation), xhr: true
        end.to change(Participation, :count).by(0)
        expect(response.status).to eq 200
        expect(response.body).to include 'Please comment first'
      end
    end
    context 'when user create recruit' do
      let!(:recruit_b) { FactoryBot.create(:recruit, user: user_a) }
      let!(:comment_b) { FactoryBot.create(:comment, user: user_a, recruit: recruit_b) }
      it "can't join with created_user" do
        login_as user_a
        expect do
          post recruit_participations_path(recruit_b), params: FactoryBot.attributes_for(:participation), xhr: true
        end.to change(Participation, :count).by(0)
        expect(response.status).to eq 200
      end
    end
  end
  describe 'DELETE #destroy' do
    let!(:user_b) { FactoryBot.create(:user) }
    let!(:participation_a) { FactoryBot.create(:participation, user: user_a, recruit: recruit_a) }
    context 'when already joined' do
      it 'is successfully deleted by joined user' do
        login_as user_a
        get recruit_path(recruit_a)
        expect(response.body).to include "changed my mind"
        expect do
          delete recruit_participation_path(recruit_id: recruit_a, id: participation_a), xhr: true
        end.to change(Participation, :count).by(-1)
        expect(response.status).to eq 200
        expect(response.body).to include "I will Join"
      end
      it "can't be deleted by not joined user" do
        login_as user_b
        expect do
          delete recruit_participation_path(recruit_id: recruit_a, id: participation_a), xhr: true
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
