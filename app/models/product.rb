class Product < ApplicationRecord
    has_many :cart_items
    has_many :carts, through: :cart_items
    belongs_to :cart
  end
  
