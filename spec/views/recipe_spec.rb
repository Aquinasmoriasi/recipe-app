require 'rails_helper'

RSpec.describe 'Testing recipes view', type: :feature do
  describe 'Recipes#index' do
    before(:each) do
      user = User.create name: 'johnson', email: 'johnson@example.com', password: 'password'
      (1..5).each do |i|
        user.recipes.create name: "Recipe number #{i}", preparation_time: 60,
                            cooking_time: 90, description: 'Steps goes here', public: true
      end

      visit new_user_session_path
      page.fill_in placeholder: 'Enter your email', with: 'johnson@example.com'
      page.fill_in placeholder: 'Enter password', with: 'password'
      click_button 'Log in'
      visit recipes_path
    end

    it 'should be able to see delete button for each recipe' do
      within('body') do
        expect(find_all('button').length).to eq 6
      end
    end
  end
end
