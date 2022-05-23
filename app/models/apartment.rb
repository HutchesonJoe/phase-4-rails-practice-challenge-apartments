class Apartment < ApplicationRecord
  validates :number, presence: true, numericality: true
  has_many :leases
  has_many :tenants, through: :leases
end
