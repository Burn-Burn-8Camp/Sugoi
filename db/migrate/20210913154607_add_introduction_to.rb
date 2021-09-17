class AddIntroductionTo < ActiveRecord::Migration[6.1]
  def change
    add_column :sellers, :introduction, :string
  end
end
