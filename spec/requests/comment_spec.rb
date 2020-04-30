require 'rails_helper'

describe 'Comment', type: :request do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:recruit_a) { FactoryBot.create(:recruit) }
  let!(:comment_a) { FactoryBot.create(:comment, user: user_a, recruit: recruit_a) }
  before { login_as user_a }
  describe 'POST #create' do
    context 'with correct parameters' do
      it 'is successfully created' do
        get recruit_path(recruit_a)
        expect do
          post recruit_comments_path(recruit_a), params: FactoryBot.attributes_for(:comment, content: 'test'), xhr: true
        end.to change(Comment, :count).by(1)
        expect(response.status).to eq 200
        expect(response.body).to include 'test'
        expect(response.body).to include "(#{recruit_a.comments.count})"
      end
    end
    context 'with empty content' do
      it 'shows error page' do
        post recruit_comments_path(recruit_a), params: { content: nil }, xhr: true
        expect(response.status).to eq 200
      end
    end
  end
  describe 'DELETE #destroy' do
    let!(:user_b) { FactoryBot.create(:user) }
    context 'delete a comment' do
      it 'is successfully deleted by commented user' do
        expect do
          delete recruit_comment_path(recruit_id: recruit_a, id: comment_a), xhr: true
        end.to change(Comment, :count).by(-1)
        expect(response.status).to eq 200
      end
      it "can't be deleted by not commented user" do
        login_as user_b
        expect do
          delete recruit_comment_path(recruit_id: recruit_a, id: comment_a), xhr: true
        end.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
