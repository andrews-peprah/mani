module LevelCalculatorable
  extend ActiveSupport::Concern

  module ClassMethods

  end

  # Geneate doorkeeper application for client
  # @params null
  # @return null
  def level
    # Calculate the level of individual
    Math.cbrt(self.children.size).to_i 
  end  
end