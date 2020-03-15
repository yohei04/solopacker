require 'rails_helper'

describe 'Join', type: :request do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:recruit_a) { FactoryBot.create(:recruit) }
  # let!(:join_a) { FactoryBot.create(:join, user: user_a, recruit: recruit_a) }
  describe 'POST #create' do
    context 'when user_a not joined' do
      it 'is successfully created' do
        login_as user_a
        get recruit_path(recruit_a)
        expect(response.body).to include "joins(#{recruit_a.joins.count.to_s})"
        expect do
          post recruit_joins_path(recruit_a), params: FactoryBot.attributes_for(:join)
        end.to change(Join, :count).by(1)
        expect(response.status).to eq 302
      end
    end
    context 'when user_a joined already' do
      let!(:join_a) { FactoryBot.create(:join, user: user_a, recruit: recruit_a) }
      let!(:user_b) { FactoryBot.create(:user) }
      it "can't create again" do
        login_as user_a
        expect do
          post recruit_joins_path(recruit_a), params: FactoryBot.attributes_for(:join)
        end.to change(Join, :count).by(0)
      end
      it "is successfully created by other user" do
        login_as user_b
        expect do
          post recruit_joins_path(recruit_a), params: FactoryBot.attributes_for(:join)
        end.to change(Join, :count).by(1)
        expect(response.status).to eq 302
      end
    end
  end
  describe 'DELETE #destroy' do
    let!(:join_a) { FactoryBot.create(:join, user: user_a, recruit: recruit_a) }
    context 'when already joined' do
      it 'is successfully deleted' do
        login_as user_a
        expect do
          delete recruit_join_path(recruit_id: recruit_a, id: join_a)
        end.to change(Join, :count).by(-1)
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.status).to eq 200
      end
    end
  end
end
