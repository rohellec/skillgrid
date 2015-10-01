require 'rails_helper'

describe User do
  let(:user) { new_user }
  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:crypted_password) }

  it { should be_valid }

  describe "with empty name" do
    before { user.name = "" }
    it { should_not be_valid }
  end

  describe "with empty email" do
    before { user.email = "" }
    it { should_not be_valid }
  end

  describe "with too large name" do
    before { user.name = 'a' * 51}
    it {should_not be_valid}
  end

  describe "with too large email" do
    before { user.email = 'a' * 51 + '@example.com' }
    it { should_not be_valid }
  end

  describe "with invalid email format" do
    it "should be invalid" do
      invalid_adresses.each do |address|
        user.email = address
        expect(user).not_to be_valid
      end
    end
  end

  describe "with valid email format" do
    it "should be valid" do
      valid_adresses.each do |address|
        user.email = address
        expect(user).to be_valid
      end
    end
  end

  describe "with the same email" do
    before { duplicate_user(user) }
    it { should_not be_valid }
  end

  describe "with email in mixed case" do
    let(:mixed_case) { "mIXeD@EMaiL.COm" }

    it "should be saved in downcase" do
      save_with_options(user, email: mixed_case)
      expect(user.reload.email).to eq(mixed_case.downcase)
    end
  end

  describe "with empty password" do
    before { user.password = user.password_confirmation = '' }
    it { should_not be_valid }
  end

  describe "with too short password" do
    before { user.password = user.password_confirmation = 'a' * 5 }
    it { should_not be_valid }
  end

  describe "with confirmation that doesn't match password" do
    before { user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end
end
