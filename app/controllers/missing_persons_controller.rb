class MissingPersonsController < ActionController::Base
    def index
    end

    def search
	if (@params['form'].nil?)
	    return redirect_to :action => 'index'
	end
    end
end
