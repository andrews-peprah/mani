module LevelCalculatorable
  extend ActiveSupport::Concern

  module ClassMethods

  end

  # Generates the level
  #
  def level
    get_level(0,self.children.where(is_verified: true).size,0)
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
