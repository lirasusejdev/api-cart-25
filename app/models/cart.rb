
class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  scope :inactive_for, ->(hours) { where("last_activity_at < ?", hours.hours.ago) }
  scope :abandoned_longer_than, ->(days) { where(abandoned: true).where("last_activity_at < ?", days.days.ago) }

  def self.mark_abandoned_carts!
    inactive_for(3).where(abandoned: false).find_each(&:mark_as_abandoned!)
  end

  def self.delete_old_abandoned_carts!
    abandoned_longer_than(7).find_each(&:destroy)
  end

  def mark_as_abandoned!
    update!(abandoned: true)
  end
end
