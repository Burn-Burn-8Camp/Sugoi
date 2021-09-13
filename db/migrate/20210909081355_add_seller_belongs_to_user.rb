class AddSellerBelongsToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference(:sellers, :user, index: true)
  end
end
