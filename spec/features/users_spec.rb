# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:current_user) { create(:user, password: 'caplin') }

  before :each do
    create(:article, title: 'test title', user_id: current_user.id)
    user = create(:user)
    create(:article, user_id: user.id)
    create(:user)
  end

  context 'signs me in' do
    scenario 'should be successful' do
      visit user_session_path
      within('form') do
        fill_in 'Email', with: current_user.email
        fill_in 'Password', with: 'caplin'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Show user', count: 2)
      find(:xpath, "//a[@href='/users/#{current_user.slug}']").click
      expect(page).to have_content(current_user.email)
      expect(page).to have_content('test title')
      expect(page).to have_current_path(user_path(current_user.slug))
    end
  end
end
