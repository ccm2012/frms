require "bcrypt"

class Customer < ApplicationRecord
  include BCrypt
  ATTRIBUTE_PARAMS = %i(name email phone_num password
    password_confirmation).freeze
  NO_PASS_ATTRIBUTE_PARAMS = %i(name email phone_num).freeze

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable,
    omniauth_providers: [:google_oauth2]

  has_many :orders, dependent: :destroy

  validates :email, presence: true
  validates :name, presence: true
  validates :phone_num, presence: true

  class << self
    def new_with_session params, session
      super.tap do |customer|
        data = session["devise.facebook_data"]
        if data && data["extra"]["raw_info"]
          customer.email = data["email"] if customer.email.blank?
        end
      end
    end

    def from_omniauth aut
      where(provider: aut.provider, uid: aut.uid).first_or_create do |customer|
        auth_info = aut.info
        asign_customer customer, auth_info
      end
    end

    private

    def asign_customer customer, auth_info
      customer.email = auth_info.email
      customer.password = Devise.friendly_token[0, 20]
      customer.encrypted_password =
        BCrypt::Password.create ENV["GMAIL_PASSWORD"]
      customer.name = auth_info.name.titleize
    end
  end
end
