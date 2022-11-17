require 'rails_helper'

RSpec.describe 'Testing food views', type: :feature do
  describe 'Food#index' do
    before(:each) do
      user = User.create(name: 'johnson', email: 'johnson@example.com', password: 'password')
      (1..5).each { |i| user.foods.create(name: "Test food #{i}", quantity: 3, price: 10, measurement: 'grams') }

      visit new_user_session_path

      page.fill_in placeholder: 'Enter your email', with: 'johnson@example.com'
      page.fill_in placeholder: 'Enter password', with: 'password'
      click_button 'Log in'
      visit foods_path
    end

    it 'can see all the food' do
      expect(page).to have_content 'Test food 1'
      expect(page).to have_content 'Test food 2'
      expect(page).to have_content 'Test food 3'
      expect(page).to have_content 'Test food 4'
      expect(page).to have_content 'Test food 5'
    end

    it 'should be able to see delete buttons for each food' do
      within('table') do
        expect(find_all('delete').length).to eq 0
      end
    end
  end
end
