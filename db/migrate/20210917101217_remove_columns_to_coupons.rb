class RemoveColumnsToCoupons < ActiveRecord::Migration[6.1]
  def change
    remove_columns :coupons, :status
  end
end
