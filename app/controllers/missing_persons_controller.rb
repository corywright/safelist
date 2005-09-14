#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class MissingPersonsController < ActionController::Base
	  before_filter :login_required
    def index
    end

    def search
	if (@params['search_string'].nil?)
	    return redirect_to :action => 'index'
	end
    end

    def search2
	if (@params['search_string'].nil?)
	    return redirect_to :action => 'index'
	end
    end
end
