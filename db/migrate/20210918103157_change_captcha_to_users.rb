class ChangeCaptchaToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :captcha, :integer, limit: 6
  end
end
