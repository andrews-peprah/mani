module LevelCalculatorable
  extend ActiveSupport::Concern

  module ClassMethods

  end

  # Generates the level
  #
  def level
    # get the list of children
    # and the children for the current child
    # DIAGRAM
    #           #
    #         _/|\__
    #       #   #   #
    #     # # # ...  ...
    @total = 0
    count_children
    get_level(0,@total,0)
  end

  # Gives the total number of children
  def total_children
    @total = 0
    count_children
    @total
  end

  # Counts the number of children
  #
  def count_children(parent_node = self,level=0)
    # Check current level if the level is 4 go back one
    level += 1

    if level <= 4 
      # Get children nodes
      nodes = parent_node.children

      if nodes.present?
        # Add the number of children to total
        @total += nodes.size

        nodes.each do |node|
            count_children(node,level)
        end
        level -= 1
      end
    else
      level -= 1
    end
    @level
  end

  # Geneate doorkeeper application for client
  # @params null
  # @return null
  def get_level(current_level=1,children=0,new_level = 0)
    # Calculate the level of individual
    rem = children - (3 ** current_level)
    if(rem < 0)
      return new_level
    else
      get_level(current_level+=1,rem,new_level+=1)
    end
  end

  # Calculates the current amount earned by customer
  def calculate_amount(children_size)
    case children_size
    when 3
      21
    when 12
      54
    when 39
      135
    when 120
      324
    when 363
      566
    else
      0
    end
  end
end
