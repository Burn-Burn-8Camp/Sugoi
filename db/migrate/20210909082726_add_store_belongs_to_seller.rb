class AddStoreBelongsToSeller < ActiveRecord::Migration[6.1]
  def change
    remove_reference(:stores, :user, index: true)
  end
end
