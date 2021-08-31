class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]


  def self.create_from_provider_data(provider_data)
    return nil if provider_data.nil?

    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.account = provider_data.info.email.split('@').first
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.picture = provider_data.info.image
    end
  end
end



