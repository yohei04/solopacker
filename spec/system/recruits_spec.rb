require 'rails_helper'

describe 'Recruit page' do
  let!(:user) { FactoryBot.create(:user) }
  let!(:recruit) { FactoryBot.create(:recruit) }
  before do
    login_as user
  end
  describe '#new page' do
    before do
      visit new_recruit_path
    end
    context 'with not full information' do
      it 'shows error messages' do
        fill_in 'Title:', with: 'title'
        click_on 'Save'
        expect(page).to have_content 'errors'
      end
    end
    # context 'with full information' do
    #   it 'shows success flash' do
    #     fill_in 'Title:', with: 'title'
    #     fill_in 'autocomplete_address', with: 'tokyo'
    #     fill_in 'About your plan:', with: 'About your plan'
    #     click_on 'Save'
    #     expect(page).to have_content 'Recruit created!'
    #   end
    # end
  end
  describe '#edit page' do
    before do
      visit edit_recruit_path(recruit)
    end
    context 'visit eddit page' do
      it 'shows filled in date' do
        expect(page).to have_field 'Title:', with: recruit.title
        expect(page).to have_select('How long(h):', selected: [recruit.hour.to_s])
        expect(page).to have_field 'autocomplete_address', with: recruit.city
        expect(page).to have_field 'About your plan:', with: recruit.content
      end
    end
    context 'with not full information' do
      it 'shows error messages' do
        fill_in 'Title:', with: nil
        click_on 'Save'
        expect(page).to have_content 'error'
      end
    end
    context 'with full information' do
      it 'shows success flash' do
        click_on 'Save'
        expect(page).to have_content 'Recruit updated!'
      end
    end
  end
end
