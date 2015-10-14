require 'rails_helper'

describe Product do
  let(:product) { new_product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:description) }

  it { should be_valid }

  describe "with empty title" do
    before { product.title = "" }
    it { should_not be_valid }
  end

  describe "with empty description" do
    before { product.description = "" }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { product.title = 'a' * 101 }
    it  { should_not be_valid }
  end
end
