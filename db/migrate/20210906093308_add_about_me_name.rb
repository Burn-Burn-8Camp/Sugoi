class AddAboutMeName < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :gender, :string
    add_column :users, :birth, :date
    add_column :users, :country, :string
    add_column :users, :avatar, :st
  end
end
