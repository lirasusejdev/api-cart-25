require "test_helper"

class ManageAbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform
    Cart.mark_abandoned_carts!
    Cart.delete_old_abandoned_carts!
  end
end


