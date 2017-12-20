class ChangeOrder < ApplicationRecord
  belongs_to :staff
  belongs_to :order
end
