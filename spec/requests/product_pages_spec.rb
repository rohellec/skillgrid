require 'rails_helper'

describe "Product Pages" do
  subject { page }

  describe "Product page" do
    let(:product) { FactoryGirl.create(:product) }
    before { visit product_path(product) }

    it { should have_title(product.title) }
    it { should have_selector("h1", text: product.title) }
  end

  describe "CreateProduct page" do
    let(:title)  { "Create product" }
    let(:submit) { "Create product" }
    before { visit new_product_path }

    it { should have_title(title) }
    it { should have_selector("h1", text: title) }

    describe "with invalid information" do
      it "should not create a product" do
        expect { click_button submit }.not_to change(Product, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(title) }
        it { should have_error_message("error") }
      end
    end

    describe "with valid information" do
      let(:product) { new_product }
      let(:title) { product.title }
      before { fill_in_product_form(product) }

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(title) }
        it { should have_selector("h1", text: title) }
        it { should have_success_message("created") }

        describe "and then returning back to home page" do
          before { visit root_path }
          it { should_not have_success_message("") }
        end
      end
    end
  end

  describe "Index Page" do
    before(:all) { 20.times { FactoryGirl.create(:product) } }
    before { visit products_path }
    after(:all) { Product.delete_all }

    it { should have_title("All products") }
    it { should have_selector("h1", text: "All products") }

    it "should list each product" do
      Product.all.each do |product|
        expect(page).to have_selector("li", text: product.title)
      end
    end
  end
end
