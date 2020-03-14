require 'rails_helper'

RSpec.describe Join, type: :model do
  describe 'Join Model' do
    let!(:join_a) { FactoryBot.create(:join) }
    context 'when join is created' do
      it 'has to have user_id' do
        join_a.user_id = nil
        join_a.valid?
        expect(join_a.errors[:user_id]).to include("can't be blank")
      end
      it 'has to have recruit_id' do
        join_a.recruit_id = nil
        join_a.valid?
        expect(join_a.errors[:recruit_id]).to include("can't be blank")
      end
      it 'has user and recruit' do
        expect(join_a.user).to be_present
        expect(join_a.recruit).to be_present
      end
      it 'has unique user_id and recruit_id pair' do
        duplicate_join = join_a.dup
        expect(duplicate_join).to be_invalid
      end
    end
    context 'when user and recruit have several joins' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:join_a) { FactoryBot.create(:join, user: user_a) }
      let!(:join_b) { FactoryBot.create(:join, user: user_a) }
      let!(:join_c) { FactoryBot.create(:join, recruit: recruit_a) }
      let!(:join_d) { FactoryBot.create(:join, recruit: recruit_a) }
      it 'is valid' do
        expect(user_a.joins.count).to eq 2
        expect(recruit_a.joins.count).to eq 2
      end
    end
    context 'when delete user' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:join_a) { FactoryBot.create(:join, user: user_a) }
      it 'is deleted too' do
        expect { user_a.destroy }.to change { Join.count }.by(-1)
      end
    end
    context 'when delete recruit' do
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:join_a) { FactoryBot.create(:join, recruit: recruit_a) }
      it 'is deleted too' do
        expect { recruit_a.destroy }.to change { Join.count }.by(-1)
      end
    end
  end
end
