require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is missing name' do
      category = Category.new(name: "Test Category")
      product = Product.new(name: nil, price: 99, quantity: 99, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Name can't be blank"]
    end
    it 'is missing price' do
      category = Category.new(name: "Test Category")
      product = Product.new(name: "Test", price: "", quantity: 99, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Price is not a number"]
    end
    it 'is missing quantity' do
      category = Category.new(name: "Test Category")
      product = Product.new(name: "Test", price: 99, quantity: "", category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Quantity can't be blank"]
    end
    it 'is missing category' do
      category = Category.new(name: "Test Category")
      product = Product.new(name: "Test", price: 99, quantity: 99, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Category must exist", "Category can't be blank"]
    end

    it 'saves successfully with good values' do
      category = Category.new(name: "Test Category")
      product = Product.new(name: "Test", price: 99, quantity: 99, category: category)
      expect(product).to be_valid
      expect(product.save).to be true
    end
  end
end