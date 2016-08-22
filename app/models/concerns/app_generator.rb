module AppGenerator
  extend ActiveSupport::Concern

  included do
    after_create :generate_app
  end

  module ClassMethods
    
  end

  # Geneate doorkeeper application for client
  # @params null
  # @return null
  def generate_app
    # Use doorkeeper to generate application
    doorkeeper_app = Doorkeeper::Application.new :name => self.company, :redirect_uri => "urn:ietf:wg:oauth:2.0:oob"
    doorkeeper_app.owner = self
    doorkeeper_app.save
  end
end