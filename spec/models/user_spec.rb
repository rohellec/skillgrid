require 'rails_helper'
require_relative '../support/utilities.rb'

describe User do
  let(:user) { new_user }
  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

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
end
