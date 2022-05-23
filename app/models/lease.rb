class Lease < ApplicationRecord
  validates :rent, presence: true, numericality: true
  belongs_to :apartment 
  belongs_to :tenant 
end
