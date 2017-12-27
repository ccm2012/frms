class Staff < ApplicationRecord
  enum staff_role: %i(administrator chef receptionist).freeze
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable

  has_many :change_orders, dependent: :destroy
end
