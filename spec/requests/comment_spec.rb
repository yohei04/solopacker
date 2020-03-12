require 'rails_helper'

describe 'Comment', type: :request do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:recruit_a) { FactoryBot.create(:recruit) }
  let!(:comment_a) { FactoryBot.build(:comment, user: user_a, recruit: recruit_a) }
  before do
    login_as user_a
  end
  describe 'Get #create' do
    context 'with correct parameters' do
      it 'is successfully created' do
        get recruit_path(recruit_a)
        expect(response.body).to include Comment.count.to_s
        post recruit_comments_path(recruit_a), params: { content: "test", user_id: user_a.id, recruit_id: recruit_a.id }
        follow_redirect!
        expect(response.body).to include 'test'
      end
    end
    context 'with incorrect parameters' do
      it 'shows error page' do
        get recruit_path(recruit_a)
        post recruit_comments_path(recruit_a), params: { content: nil }
        follow_redirect!
        expect(response.body).to include 'flash__alert'
      end
    end
  end
end
