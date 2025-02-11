class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :set_total_price

  private

  def set_total_price
    self.total_price = quantity * product.unit_price
  end
end

