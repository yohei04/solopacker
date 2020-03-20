require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'Participation Model' do
    let!(:participation_a) { FactoryBot.create(:participation) }
    context 'when participation is created' do
      it 'has to have user_id' do
        participation_a.user_id = nil
        participation_a.valid?
        expect(participation_a.errors[:user_id]).to include("can't be blank")
      end
      it 'has to have recruit_id' do
        participation_a.recruit_id = nil
        participation_a.valid?
        expect(participation_a.errors[:recruit_id]).to include("can't be blank")
      end
      it 'has user and recruit' do
        expect(participation_a.user).to be_present
        expect(participation_a.recruit).to be_present
      end
      it 'has unique user_id and recruit_id pair' do
        duplicate_participation = participation_a.dup
        expect(duplicate_participation).to be_invalid
      end
    end
    context 'when user and recruit have several participations' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:participation_a) { FactoryBot.create(:participation, user: user_a) }
      let!(:participation_b) { FactoryBot.create(:participation, user: user_a) }
      let!(:participation_c) { FactoryBot.create(:participation, recruit: recruit_a) }
      let!(:participation_d) { FactoryBot.create(:participation, recruit: recruit_a) }
      it 'is valid' do
        expect(user_a.participations.count).to eq 2
        expect(recruit_a.participations.count).to eq 2
      end
    end
    context 'when delete user' do
      let!(:user_a) { FactoryBot.create(:user) }
      let!(:participation_a) { FactoryBot.create(:participation, user: user_a) }
      it 'is deleted too' do
        expect { user_a.destroy }.to change { Participation.count }.by(-1)
      end
    end
    context 'when delete recruit' do
      let!(:recruit_a) { FactoryBot.create(:recruit) }
      let!(:participation_a) { FactoryBot.create(:participation, recruit: recruit_a) }
      it 'is deleted too' do
        expect { recruit_a.destroy }.to change { Participation.count }.by(-1)
      end
    end
  end
end
