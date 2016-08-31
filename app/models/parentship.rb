class Parentship < ApplicationRecord
	belongs_to :customer
  belongs_to :child, :class_name => 'Customer'
end
