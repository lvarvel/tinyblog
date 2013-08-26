require 'spec_helper'

describe "Administrator Login/Logout" do

  let(:user) {
    User.create do |u|
      u.email = "admin@example.com"
      u.password = "secret_code"
      u.password_confirmation = "secret_code"
    end
  }

  it "requires a login to visit the admin area" do
    visit "/admin/posts"

    current_path.should == "/admin/login"
  end

  it "can log in" do
    visit "/admin/login"

    #failure case
    fill_in :user_email, with: user.email
    fill_in :user_password, with: "secret_FAIL"

    click_button "Log In"

    current_path.should == "/admin/login"
    page.should have_css(".alert")
    page.should have_content("Login failed")

    #success case
    fill_in :user_email, with: "admin@example.com"
    fill_in :user_password, with: "secret_code"

    click_button "Log In"

    current_path.should == "/admin/posts"
  end

  it "can log out" do
    log_in(user)

    click_link "Logout"
    current_path.should == '/admin/login'

    page.should have_css(".notice")
    page.should have_content("You have been successfully logged out")
    page.should_not have_content("Logout")

    visit "/admin/posts"

    current_path.should == "/admin/login"
  end
end
