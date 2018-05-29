class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
         
    def self.from_omniauth(access_token)
      debugger
      data = access_token.info
      user = User.where(:email => data["email"]).first

      unless user
        password = Devise.friendly_token[0,20]
        user = User.create(user_name: data["name"], email: data["email"],
          password: password, password_confirmation: password
        )
      end
      user
    end
end
