class App < ApplicationRecord
  before_create :generate_uid
  
  belongs_to :client
  
  # Generates unique id for app and client
  # @params nil
  # @return nil
  def generate_uid
    # generate an app uid
    self.app_uid = SecureRandom.hex(32)
  end
  
end
