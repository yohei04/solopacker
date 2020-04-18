require 'rails_helper'

describe Recruit, type: :model do
  let!(:recruit) { FactoryBot.create(:recruit) }
  describe 'Recruit Model' do
    context 'when recruit is full information' do
      it 'is valid' do
        expect(recruit).to be_valid
      end
    end
    context 'when recruit is full information without user_id' do
      it 'is invalid' do
        recruit.user_id = nil
        expect(recruit).to be_invalid
      end
    end
    context 'when recruit is not full information' do
      let!(:recruit) do
        FactoryBot.build(:recruit,
                         date_time: nil, hour: nil,
                         country: nil, city: nil,
                         title: nil, content: nil)
      end
      it 'is invalid' do
        expect(recruit).to be_invalid
      end
    end
    context 'when hour has more than 24' do
      it 'is invalid' do
        recruit.hour = 25
        expect(recruit).to be_invalid
      end
    end
    context 'when title has more than 50 characters' do
      it 'is invalid' do
        recruit.title = 'a' * 51
        expect(recruit).to be_invalid
      end
    end
    context 'when content has more than 500 characters' do
      it 'is invalid' do
        recruit.content = 'a' * 501
        expect(recruit).to be_invalid
      end
    end
    context 'when user posts recruits' do
      let!(:recruit_order_2) { FactoryBot.create(:recruit, created_at: 2.years.ago) }
      let!(:recruit_order_3) { FactoryBot.create(:recruit, created_at: 10.minutes.ago) }
      it 'is most recent first' do
        expect(recruit).to eq(Recruit.create_recent.first)
      end
    end
    context 'when delete user' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:recruit) { FactoryBot.create(:recruit, user: user) }
      it 'is deleted too' do
        expect { user.destroy }.to change { Recruit.count }.by(-1)
      end
    end
  end
end
