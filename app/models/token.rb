class Token < ApplicationRecord
  belongs_to :employee
  belongs_to :client
  belongs_to :customer
end
