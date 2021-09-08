class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :image, ImageUploader
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2 ,:github]

  def self.create_from_provider_data(provider_data)
    return nil if provider_data.nil?

    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.account = provider_data.info.email.split('@').first
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.picture = provider_data.info.image
    end
  end

  def self.now_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000 
      "<i class='far fas fa-award '></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount >= 20000
      "<i class='fas fa-trophy'></i>" 
    end      
  end
  #判斷現在的總消費金額之後回傳的icon

  def self.up_rank_icon(accumulated_amount)
    if accumulated_amount <= 2000
      "<i class='fas fa-medal'></i>"
    elsif accumulated_amount < 20000
      "<i class='fas fa-trophy'></i>"
    end 
  end
  #判斷現在總消費金額的icon之後顯示下一等級的icon

  def self.user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "白銀會員"
    elsif accumulated_amount < 20000
      "尊貴會員"
    end
  end
  #顯示下一階段可升級成甚麼會員

  def self.now_user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "一般會員"      
    elsif accumulated_amount < 20000
      "白銀會員"
    elsif accumulated_amount >= 20000
      "尊貴會員"  
    end
  end
  #判斷現在的會員等級

  def self.still_need(accumulated_amount)
    if accumulated_amount < 2000
      2000 - accumulated_amount
    elsif accumulated_amount < 20000 
      20000 - accumulated_amount
    end
  end
  #判斷要完成任務還差多少消費金額
end



