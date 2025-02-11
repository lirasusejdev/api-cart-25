class AddAbandonedAndLastActivityToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :abandoned, :boolean
    add_column :carts, :last_activity_at, :datetime
  end
end
