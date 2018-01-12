class Staff < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(name email phone_num staff_role password
    password_confirmation).freeze

  enum staff_role: %i(administrator chef receptionist).freeze

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable
  mount_uploader :picture, PictureUploader

  has_many :change_orders, dependent: :destroy

  validates :name, presence: true, allow_nil: true
  validates :phone_num, presence: true, allow_nil: true

  def equal_staff? staff
    self == staff
  end
end
