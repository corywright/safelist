class MissingPersonsController < ActionController::Base
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
