class RemoveStoreFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:stores, :seller, index: true)
    add_reference(:stores, :user, index: true)
  end
end
