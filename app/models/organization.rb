class Organization < ApplicationRecord
  has_many :client_organizations
  has_many :clients, through: :client_organizations
end
