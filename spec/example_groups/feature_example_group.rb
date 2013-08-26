module FeatureExampleGroup
  extend ActiveSupport::Concern

  def log_in(user)
    visit "/admin/login"
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button "Log In"
  end
end
