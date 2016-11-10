class AdminsController < ApplicationController
  before_action :authenticate_admin!, :get_title

  def index
  end

  def show 
  end

  private
  def get_title
    @title = "Dashboard"
  end
end
