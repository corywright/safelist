#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class PortalController < ApplicationController
    before_filter :login_required
  def index
    @shelter = Shelter.find(session[:shelter_id], :include => :address)
  end

  def westernunion
  end

  def information
  end
end
