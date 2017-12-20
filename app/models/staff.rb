class Staff < ApplicationRecord
  enum staff_role: %i(administrator chef receptionist).freeze

  has_many :change_orders, dependent: :destroy
end
