class PortalController < ApplicationController
  def index
    @shelter = Shelter.find(session[:shelter_id], :include => :address)
  end

end
