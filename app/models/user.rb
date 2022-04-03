class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :omniauthable,
         omniauth_providers: [:google_oauth2, :github, :twitter, :facebook]

  include Roleable

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        email: data['email'],
        password: Devise.friendly_token[0, 20]
      )
    end
    user.uid = access_token.uid
    user.provider = access_token.provider
    unless user.name.present?
      user.name = access_token.info.name
    end
    user.image = access_token.info.image
    user.save

    user
  end

  # Default role
  after_create do
    self.update(operator: true)
  end

  def to_s
    email
  end
end
