class AddProductAndUserToRoom < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :user, index: true
    add_reference :rooms, :product, index: true
  end
end
