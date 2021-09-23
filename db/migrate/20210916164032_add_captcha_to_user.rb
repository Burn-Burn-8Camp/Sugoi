class AddCaptchaToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :captcha, :integer
  end
end
