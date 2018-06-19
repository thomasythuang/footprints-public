require './lib/repository'

class NotACraftsmanError < StandardError; end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  include ActiveModel::Validations

  mount_uploader :avatar, AvatarUploader
  
  belongs_to :craftsman

  # validate :password_complexity AMAZING method that's unfortunately not currently needed
#  def password_complexity
#    if password.present?
#      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-+;:'"])/)
#        errors.add :password, "must have a number, lowercase, uppercase and special character"
#      end
#    end
#  end
#
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    return user if user
    create(email: data['email'], name: data['name']) 
  end

  private

  attr_accessor :encrypted_password
end
