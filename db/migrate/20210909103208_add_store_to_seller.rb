class AddStoreToSeller < ActiveRecord::Migration[6.1]
  def change
    add_reference(:stores, :seller, index: true)
  end
end
