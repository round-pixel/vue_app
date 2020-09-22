class Client < ApplicationRecord
  include Deviseable

  before_validation :assign_password,  if: -> { password.nil? }

  private

    def assign_password
      self.password = '12345678'
      self.password_confirmation = '12345678'
    end
end
