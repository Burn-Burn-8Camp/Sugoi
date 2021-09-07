class AddUsersSelfAbout < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :self_about, :string
    add_column :users, :self_blog, :string
    add_column :users, :nickname, :string
    add_column :users, :nickname, :string
    add_column :users, :nickname, :string
end
