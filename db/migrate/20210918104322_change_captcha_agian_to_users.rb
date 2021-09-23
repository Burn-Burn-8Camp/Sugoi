class ChangeCaptchaAgianToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :captcha, :integer, limit: 8
  end
end
