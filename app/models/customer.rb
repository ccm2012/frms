class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable,
    omniauth_providers: [:google_oauth2]

  has_many :orders, dependent: :destroy

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
        customer.email = auth_info.email
        customer.password = Devise.friendly_token[0, 20]
        customer.name = auth_info.name
      end
    end
  end
end
