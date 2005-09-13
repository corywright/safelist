#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

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

	def app_event_types
	  @tmp = Hash.new
	  @tmp[:citizen_checkin] = 1
	  @tmp[:citizen_checkout] = 2
	  @tmp[:volunteer_checkin] = 3
	  @tmp[:volunteer_checkout] = 4
	  @tmp[:citizen_tempout] = 5
	  @tmp[:citizen_tempreturn] = 6
	  @tmp[:citizen_injuryreport] = 7
	  @tmp[:citizen_nurse] = 8
	  @tmp[:citizen_injuryresolved] = 9
	  @tmp[:member_checkin] = 10
	  @tmp[:member_checkout] = 11
	  @tmp[:org_pending] = 11
	  @tmp[:org_accepted] = 12
	  @tmp[:org_rejected] = 13
	  return @tmp
	end
end
