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

	$CITIZEN_CHECKIN = 1
	$CITIZEN_CHECKOUT = 2
	$VOLUNTEER_CHECKIN = 3
	$VOLUNTEER_CHECKOUT = 4
	$CITIZEN_TEMPOUT = 5
	$CITIZEN_TEMPRETURN = 6
	$CITIZEN_INJURYREPORT = 7
	$CITIZEN_NURSE = 8
	$CITIZEN_INJURYRESOLVED = 9
	$MEMBER_CHECKIN = 10
	$MEMBER_CHECKOUT = 11
	$ORG_PENDING = 1
	$ORG_ACCEPTED = 2
	$ORG_REJECTED = 3
end
