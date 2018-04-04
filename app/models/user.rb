require './lib/repository'

class NotACraftsmanError < StandardError; end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  include ActiveModel::Validations

  belongs_to :craftsman
  before_create :associate_craftsman

  # validate :password_complexity AMAZING method that's unfortunately not currently needed
  def password_complexity
    if password.present?
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-+;:'"])/)
        errors.add :password, "must have a number, lowercase, uppercase and special character"
      end
    end
  end

  def associate_craftsman
    craftsman = Craftsman.find_by_email(self.email)
    self.craftsman_id = craftsman.employment_id if craftsman
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user.present?
      raise ::NotACraftsmanError, "Unauthorized Login"
    end
    user
  end

  private

  def self.find_or_create_by_auth_hash(hash)
    if user = User.find_by_uid(hash['uid'])
      return user
    end

    user = User.new
    user.email = user.login = hash['info']['email']
    user.uid = hash['uid']
    user.provider = hash['provider']
    user.save!
    user
  end
end
