class AddUserNameColDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :name, 'SUGOII粉絲')
  end
end
