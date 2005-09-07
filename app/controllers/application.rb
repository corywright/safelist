# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ApplicationController < ActionController::Base
	before_filter :add_to_history

	def add_to_history
	  session[:history] ||= []
 	  session[:history].unshift ({"url" => @request.request_uri, "name" => self.controller_name + ":" + self.action_name})
	  session[:history].pop while session[:history].length > 11
	end



end
