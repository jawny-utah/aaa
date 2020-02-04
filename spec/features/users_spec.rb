# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:current_user) { create(:user, password: 'caplin') }
  let!(:article) { create(:article, title: 'created cable', description: 'update', user_id: current_user.id) }

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

  context 'find articles' do
    scenario 'should find title' do
      visit user_session_path
      within('form') do
        fill_in 'Email', with: current_user.email
        fill_in 'Password', with: 'caplin'
      end
      click_button 'Log in'
      click_on 'Create new article'
      within('form') do
        fill_in 'article_title', with: 'Active bridge'
        fill_in 'article_description', with: 'Active bridge description'
      end
      find('input[name="commit"]').click
      expect(page).to have_content('Active bridge')
      click_on 'Back'
      click_on 'Create new article'
      within('form') do
        fill_in 'article_title', with: 'Sheva'
        fill_in 'article_description', with: 'Sheva description'
      end
      find('input[name="commit"]').click
      expect(page).to have_content('Sheva')
      expect(page).to have_content('Sheva description')
      first('.accepted-articles-current-user').click_link('Edit article')
      within('form') do
        fill_in 'article_title', with: 'Sheva123'
        fill_in 'article_description', with: 'Sheva description123'
      end
      find('input[name="commit"]').click
      expect(page).to have_content('Sheva123')
      expect(page).to have_content('Edit article', count: 3)
    end

    scenario 'active cable update' do
      visit user_session_path
      within('form') do
        fill_in 'Email', with: current_user.email
        fill_in 'Password', with: 'caplin'
      end
      click_button 'Log in'
      create(:article, title: 'active cable', description: 'create then update', user_id: current_user.id)
      find(:xpath, "//a[@href='/users/#{current_user.slug}']").click
      expect(page).to have_content('created cable')
      article.update(title: 'active bridge')
      expect(page).not_to have_content('created cable')
      expect(page).to have_content('active bridge')
      expect(page).to have_content('Edit article', count: 2)
      article.destroy
      expect(page).to have_css('.accepted-articles-current-user', count: 1)
      expect(page).not_to have_css('.accepted-articles-current-user', count: 2)
    end
  end
end
