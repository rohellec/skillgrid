require 'rails_helper'

describe "Product Pages" do
  let(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "Show page" do
    let(:product) { FactoryGirl.create(:product) }
    before { visit product_path(product) }

    it { should have_title(product.title) }
    it { should have_selector("h1", text: product.title) }
    it { should_not have_link("Add to Cart") }

    describe "after logging in" do
      before do
        valid_log_in(user)
        visit product_path(product)
      end

      it { should have_link("Add to Cart") }
      it { should have_link("Edit") }
      it { should have_link("Delete") }

      it "clicking 'Delete' link should decrease number of products" do
        expect { click_link "Delete" }.to change(Product, :count).by(-1)
      end

      describe "and clicking 'Delete' link" do
        before { click_link "Delete" }

        it { should have_success_message("deleted") }
        it { should have_title("All products") }
      end

      it "clicking 'Add to Cart' should increase number of products in cart" do
        expect { click_link "Add to Cart" }.to change(CartItem, :count).by(1)
      end

      describe "and clicking 'Add to Cart' button" do
        before { click_link "Add to Cart" }

        it { should have_success_message("added") }
        it { should have_title(product.title) }
        it { should have_link("Remove from Cart") }

        it "clicking 'Remove from Cart' should decrease number of products in cart" do
          expect { click_link "Remove from Cart" }.to change(CartItem, :count).by(-1)
        end

        describe "and then clicking 'Remove from Cart' button" do
          before { click_link "Remove from Cart" }
          it { should have_title(product.title) }
        end
      end
    end
  end

  describe "New page" do
    let(:title)  { "Create product" }
    let(:submit) { "Create product" }
    before do
      valid_log_in user
      visit new_product_path
    end

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
      before { fill_in_product_form(product) }

      it "should create a product" do
        expect { click_button submit }.to change(Product, :count).by(1)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_title(product.title) }
        it { should have_selector("h1", text: product.title) }
        it { should have_success_message("created") }

        describe "and then returning back to home page" do
          before { visit root_path }
          it { should_not have_success_message("") }
        end
      end
    end
  end

  describe "Edit page" do
    let(:title) { "Edit product" }
    let(:product) { FactoryGirl.create(:product) }
    before do
      valid_log_in user
      visit edit_product_path(product)
    end

    it { should have_title(title) }
    it { should have_selector("h1", text: title) }

    describe "with invalid information" do
      before do
        invalid_title = 'a' * 101
        fill_in "Title", with: invalid_title
        click_button "Update product"
      end

      it { should have_title(title) }
      it { should have_error_message("error") }
    end

    describe "with valid information" do
      let(:new_title) { "New title" }
      before do
        fill_in_product_form(product, title: new_title)
        click_button "Update product"
      end

      it { should have_title(new_title) }
      it { should have_success_message("updated") }
      specify { expect(product.reload.title).to eq new_title }
    end
  end

  describe "Index Page" do
    before { visit products_path }

    it { should have_title("All products") }
    it { should have_selector("h1", text: "All products") }

    describe "pagination" do
      before(:all) { 20.times { FactoryGirl.create(:product) } }
      after(:all) { Product.delete_all }

      it { should have_selector("div.pagination") }

      it "should list each product" do
        Product.paginate(page: 1, per_page: 15).each do |product|
          expect(page).to have_selector("li", text: product.title)
        end
      end
    end
  end
end
