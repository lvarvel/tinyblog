require 'spec_helper'

describe Admin::SessionsController do
  describe "GET new" do
    it "works" do
      get :new
      response.should be_success
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    let!(:user) do
      FactoryGirl.build(:user, id: 1,
        email: "admin@example.com",
        password: "guest",
        password_confirmation: "guest"
      )
    end

    def do_request
      post :create, user_email: user.email, user_password: "guest"
    end

    context "when the admin authenticates successfully" do
      before do
        User.stub(:authenticate_with_email_and_password).and_return(user)
      end

      it "authenticates the admin" do
        User.should_receive(:authenticate_with_email_and_password).with(user.email, "guest").and_return(user)
        do_request
      end

      it "sets the session admin id" do
        do_request
        session[:user_id].should == user.id
      end

      it "redirects to the admin section posts list" do
        do_request
        response.should redirect_to([:admin, :posts])
      end
    end

    describe "when the admin fails to authenticate" do
      before do
        User.stub(:authenticate_with_email_and_password).and_return(nil)
      end

      it "clears the session admin id" do
        session[:user_id] = "not cleared"
        do_request
        session[:user_id].should be_nil
      end

      it "re-renders new" do
        do_request
        response.should render_template(:new)
        response.should be_not_found
      end

      it "flashes an error" do
        do_request
        flash[:alert].should be_present
      end
    end
  end

  describe "DELETE destroy" do
    it "clears the admin id from session" do
      session[:user_id] = "I'm in your base"
      delete :destroy

      session[:user_id].should be_nil
    end

    it "redirects to log in and flashes a notice" do
      delete :destroy
      response.should redirect_to([:admin, :login])
      flash[:notice].should be_present
    end
  end
end
