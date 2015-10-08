require 'rails_helper'

describe SessionsController do

  describe "when log in" do
    let (:password) { "foobar" }
    let (:user) { FactoryGirl.create(:user, password: password) }

    describe "with remembering" do
      before { login_user_and_remember(user, password: password) }

      specify "cookies should not be nil" do
        expect(cookies["remember_me_token"]).not_to be_nil
      end
    end

    describe "without remembering" do
      before { login_user(user, password: password) }

      specify "cookies should be nil" do
        expect(cookies["remember_me_token"]).to be_nil
      end
    end
  end
end
