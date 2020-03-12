require 'rails_helper'

describe Comment, type: :model do
  describe 'Comment Model' do
    let!(:comment_a) { FactoryBot.create(:comment) }
    context 'when user_id is nil' do
      it 'can\'t be blank' do
        comment_a.user_id = nil
        comment_a.valid?
        expect(comment_a.errors[:user_id]).to include('can\'t be blank')
      end
    end
    context 'when recruit_id is nil' do
      it 'can\'t be blank' do
        comment_a.recruit_id = nil
        comment_a.valid?
        expect(comment_a.errors[:recruit_id]).to include('can\'t be blank')
      end
    end
    context 'when content is nil' do
      it 'can\'t be blank' do
        comment_a.content = nil
        comment_a.valid?
        expect(comment_a.errors[:content]).to include('can\'t be blank')
      end
    end
    context 'when content has more than 200 characters' do
      it 'is too long' do
        comment_a.content = 'a' * 201
        comment_a.valid?
        expect(comment_a.errors[:content]).to include('is too long (maximum is 200 characters)')
      end
    end
    context 'when comment is created' do
      it 'has user and recruit' do
        expect(comment_a.user).to be_present
        expect(comment_a.recruit).to be_present
      end
    end
    context 'when user and recruit have several comments' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:comment_a) { FactoryBot.create(:comment, user: user_a) }
      let!(:comment_b) { FactoryBot.create(:comment, user: user_a) }
      let!(:comment_c) { FactoryBot.create(:comment, recruit: recruit_a) }
      let!(:comment_d) { FactoryBot.create(:comment, recruit: recruit_a) }
      it 'is valid' do
        expect(user_a.comments.count).to eq 2
        expect(recruit_a.comments.count).to eq 2
      end
    end
    context 'when delete user' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:comment_a) { FactoryBot.create(:comment, user: user_a) }
      it 'is deleted too' do
        expect { user_a.destroy }.to change { Comment.count }.by(-1)
      end
    end
    context 'when delete recruit' do
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:comment_a) { FactoryBot.create(:comment, recruit: recruit_a) }
      it 'is deleted too' do
        expect { recruit_a.destroy }.to change { Comment.count }.by(-1)
      end
    end
  end
end
