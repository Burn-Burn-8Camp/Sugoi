class AddColToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :delivery, :integer
  end
end
