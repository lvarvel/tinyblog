require 'spec_helper'

describe User do
 describe "validations" do
    it { should ensure_length_of(:password).is_at_least(4) }
    #shoulda matchers aren't totally Rails 4 compatible yet (8/25/2013)
    xit { should validate_confirmation_of :password }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should_not allow_value("no-hostname").for(:email) }
    it { should allow_value("dnsmaster@vanity-tld").for(:email) }

    describe "with a new record and empty password" do
      subject do
        FactoryGirl.build(:user).tap do |user|
          user.password = ""
          user.password_confirmation = ""
        end
      end

      it "validates presence of password" do
        subject.should_not be_valid
      end
    end

    describe "with an existing record and a non-empty password" do
      let(:user) { users(:user) }

      it "validates presence of password" do
        user.password = 'pwd'
        user.should_not be_valid
      end
    end
  end

  describe ".authenticate_with_email_and_password" do
    def do_action
      User.authenticate_with_email_and_password('email@example.com', 'mypass')
    end

    it "should find a user with the given email" do
      User.should_receive(:find_by_email).with('email@example.com')
      do_action
    end

    context "when there is a record with the email" do
      before do
        User.stub(:find_by_email).and_return(subject)
      end

      it "authenticates the user with the password" do
        subject.should_receive(:authenticate).with('mypass')
        do_action
      end

      it "returns the user when the password authenticates successfully" do
        subject.stub(:authenticate).and_return(true)
        do_action.should == subject
      end

      it "returns nil when the password doesn't authenticate successfully" do
        subject.stub(:authenticate).and_return(false)
        do_action.should be_nil
      end
    end

    it "returns nil when there is a record with the email" do
      User.stub(:find_by_email).and_return(nil)
      do_action.should be_nil
    end
  end
end
