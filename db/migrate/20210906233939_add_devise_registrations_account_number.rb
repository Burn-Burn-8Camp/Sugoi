class AddDeviseRegistrationsAccountNumber < ActiveRecord::Migration[6.1]
  def change
    add_column :registrations, :account_number, :string
  end
end
