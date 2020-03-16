require 'rails_helper'

describe 'Comment', type: :request do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:recruit_a) { FactoryBot.create(:recruit) }
  let!(:comment_a) { FactoryBot.create(:comment, user: user_a, recruit: recruit_a) }
  before do
    login_as user_a
  end
  describe 'POST #create' do
    context 'with correct parameters' do
      it 'is successfully created' do
        expect do
          post recruit_comments_path(recruit_a), params: FactoryBot.attributes_for(:comment, content: 'test')
        end.to change(Comment, :count).by(1)
        expect(response.status).to eq 302
        get recruit_path(recruit_a)
        expect(response.body).to include 'test'
        expect(response.body).to include "comments(#{recruit_a.comments.count})"
      end
    end
    context 'with incorrect parameters' do
      it 'shows error page' do
        post recruit_comments_path(recruit_a), params: { content: nil }
        follow_redirect!
        expect(response.body).to include 'flash__alert'
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'delete a comment' do
      it 'is successfully deleted' do
        expect do
          delete recruit_comment_path(recruit_id: recruit_a, id: comment_a)
        end.to change(Comment, :count).by(-1)
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.body).to include 'flash__notice'
      end
    end
  end
end
