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
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation)
        end.to change(Participation, :count).by(1)
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.body).to include 'You joined this recruit!'
      end
    end
    context 'when user joined already' do
      let!(:user_b) { FactoryBot.create(:user) }
      let!(:comment_a) { FactoryBot.create(:comment, user: user_b, recruit: recruit_a) }
      let!(:participation_a) { FactoryBot.create(:participation, user: user_a, recruit: recruit_a) }
      it "can't create again" do
        login_as user_a
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation)
        end.to change(Participation, :count).by(0)
      end
      it 'is successfully created by other user' do
        login_as user_b
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation)
        end.to change(Participation, :count).by(1)
        expect(response.status).to eq 302
      end
    end
    context "when user didn't comment yet" do
      let!(:user_c) { FactoryBot.create(:user) }
      it "can't join" do
        login_as user_c
        expect do
          post recruit_participations_path(recruit_a), params: FactoryBot.attributes_for(:participation)
        end.to change(Participation, :count).by(0)
        follow_redirect!
        expect(response.body).to include 'Please comment first'
      end
    end
    context 'when user create recruit' do
      let!(:recruit_b) { FactoryBot.create(:recruit, user: user_a) }
      let!(:comment_b) { FactoryBot.create(:comment, user: user_a, recruit: recruit_b) }
      it "can't join with created_user" do
        login_as user_a
        expect do
          post recruit_participations_path(recruit_b), params: FactoryBot.attributes_for(:participation)
        end.to change(Participation, :count).by(0)
      end
    end
  end
  describe 'DELETE #destroy' do
    let!(:participation_a) { FactoryBot.create(:participation, user: user_a, recruit: recruit_a) }
    context 'when already joined' do
      it 'is successfully deleted' do
        login_as user_a
        expect do
          delete recruit_participation_path(recruit_id: recruit_a, id: participation_a)
        end.to change(Participation, :count).by(-1)
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.status).to eq 200
      end
    end
  end
end
