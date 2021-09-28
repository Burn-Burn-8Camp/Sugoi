class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :image, ImageUploader
  
  # validates_uniqueness_of :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: [:google_oauth2 ,:github]
  has_many :orders
  has_many :comments
  has_one :store
  has_many :user_coupons
  has_many :coupons, through: :user_coupons
  
  has_many :bookmarks
  has_many :favorite_items, 
            through: :bookmarks,
            source: :product
  has_one_attached :image

  def self.create_from_provider_data(provider_data)
    return nil if provider_data.nil?
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.account = oauth_account(provider_data.info.email.split('@').first)
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.picture = provider_data.info.image
    end
  end

  def self.user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "白銀會員"
    elsif accumulated_amount < 20000
      "尊貴會員"
    end
  end

  def self.now_user_rank(accumulated_amount)
    if accumulated_amount <= 2000
      "一般會員"      
    elsif accumulated_amount < 20000
      "白銀會員"
    elsif accumulated_amount >= 20000
      "尊貴會員"  
    end
  end

  def self.still_need(accumulated_amount)
    if accumulated_amount < 2000
      2000 - accumulated_amount
    elsif accumulated_amount < 20000 
      20000 - accumulated_amount
    end
  end

  def self.oauth_account(account)
    return random_account if account
    User.where(account: account).exists? ? "#{account}_#{random_account}" : account
  end

  def self.random_account
    (0...8).map { (65 + rand(26)).chr }.join
  end
end