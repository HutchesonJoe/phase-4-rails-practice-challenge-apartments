class LeaseSerializer < ActiveModel::Serializer
  attributes :rent
  belongs_to :tenant
  belongs_to :apartment
end
