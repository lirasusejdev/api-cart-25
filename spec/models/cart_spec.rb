require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "calcula o preço total corretamente" do
    cart = Cart.create
    product = Product.create(name: "Produto X", unit_price: 10.0)
    cart.cart_items.create(product: product, quantity: 2, total_price: 20.0)

    expect(cart.total_price).to eq(20.0)
  end
end
