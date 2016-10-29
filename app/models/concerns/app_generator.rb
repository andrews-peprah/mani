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
    app = Doorkeeper::Application.new :name => self.company, :redirect_uri => "urn:ietf:wg:oauth:2.0:oob"
    app.owner = self
    app.save
  end
end