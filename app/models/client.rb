class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :customers,  dependent: :destroy
  has_many :employees,  dependent: :destroy
  has_many :tokens,     dependent: :destroy
  has_many :apps,       dependent: :destroy
  has_many :oauth_applications, class_name: 'Doorkeeper::Application', as: :owner, dependent: :destroy
  
  include AppGenerator
end
