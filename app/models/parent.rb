class Parent < ApplicationRecord
	belongs_to :customer
  belongs_to :parent, :class_name => 'Customer'
end
