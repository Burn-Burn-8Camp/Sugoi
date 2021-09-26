class AddRandomUrl < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :friendly_id, :string
    add_index :orders, :friendly_id, :unique => true

    Order.find_each do |e|
      e.update( :friendly_id => SecureRandom.uuid )
    end
  end
end
