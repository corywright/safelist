class PortalController < ApplicationController
  def index
    @shelter = Shelter.find(session[:shelter_id], :include => :address)
  end

  def westernunion
  end

  def information
  end
end
