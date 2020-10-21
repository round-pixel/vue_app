class Organization < ApplicationRecord
  has_many :client_organizations
  has_many :clients, through: :client_organizations

  has_many :equipments

  scope :without_client, -> (client_id) {
    where.not(id: ClientOrganization.where(client_id: client_id).select(:organization_id))
  }
end
