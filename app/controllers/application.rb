# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ApplicationController < ActionController::Base
	before_filter :add_to_history
	before_filter :get_shelter

	def add_to_history
	  session[:history] ||= []
 	  session[:history].unshift({"url" => @request.request_uri, "name" => self.controller_name + ":" + self.action_name})
	  session[:history].pop while session[:history].length > 11
	end

	def get_shelter
	  @shelter = Shelter.find_by_domain(@request.host)
	  if @shelter
	    session[:shelter_id] = @shelter.id
	  else
	    session[:shelter_id] = 1
	  end
	end

	def paginate_collection(collection, options = {})
	  default_options = {:per_page => 20, :page => 1}
	  options = default_options.merge options

	  pages = Paginator.new self, collection.size, options[:per_page], options[:page]
	  first = pages.current.offset
	  last = [first + options[:per_page], collection.size].min
	  slice = collection[first...last]
	  return [pages, slice]
	end

end
