class Equipment < ApplicationRecord
  self.inheritance_column = false

  belongs_to :organization
end
