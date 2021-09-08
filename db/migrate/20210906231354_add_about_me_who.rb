class AddAboutMeWho < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :self_about, :string
    add_column :users, :self_blog, :string
    add_column :users, :self_web, :string
    add_column :users, :life_shopping, :string
    add_column :users, :life_design, :string

  end
end
