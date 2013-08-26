require 'spec_helper'

describe 'Posting', :js do

  it 'shows the most recent post on the landing page' do
    visit '/'
    page.should have_content 'INTERCAL'
    page.should have_content 'hate programming'
  end

  context 'when logged in' do
     before do
      visit '/admin/login'
      fill_in :user_email, with: 'first_admin@example.com'
      fill_in :user_password, with: 'password'
      click_button "Log In"
    end

    it 'allows users to create a post' do
      visit '/admin/posts/new'

      fill_in 'Title', with: 'How to tickle a wombat'
      fill_in 'Body', with: 'First, you need a feather and a potato cannon.'
      check 'Published'
      click_button 'Save'

      visit '/'
      page.should have_content('feather and a potato cannon.')
    end
  end
end
