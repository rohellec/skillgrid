require 'rails_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include page title" do
      expect(full_title("foo")).to match /foo/
    end

    it "should start with base title" do
      expect(full_title("foo")).to match /^Skillgrid/
    end

    it "shouldn't have page title if it's not present" do
      expect(full_title('')).to match /^Skillgrid$/
    end
  end
end
