module Mani
  module HierarchyBuilder
    # TODO: Put into a worker
    # Sends notification to customer
    def rebuild(customer)
      # Get customer's parent
      parent_customer = customer.parent

      if parent_customer.present?
        # If the parent's children exceeds 3
        # Associate the child node to another parent
        if parent_customer.verified_children.size > 3
          change_parent(customer)
        end
      else
        false
      end
    end

    # Changes the parent node
    def change_parent(customer)
      parent_customer = customer.parent

      if parent_customer.present?
        # If the parent_customer is present
        # get the children under customer
        # excluding the customer himself
        siblings = parent_customer.verified_children.where.not(id: customer.id)

        if siblings.present?
          # Pick one sibling and assign the customer to sibling
          sibling = siblings.first
          
          # remove relationship between customer and parent
          parent_customer.children.delete(customer)

          puts "puts change parent called"
          # assigning customer to sibling
          sibling.children << customer
          customer.parent = sibling
        end
      end
    end

    module_function :rebuild, :change_parent
  end
end