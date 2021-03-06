#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
require_dependency "login_system" 
class ApplicationController < ActionController::Base
	model :user
	include LoginSystem
	before_filter :add_to_history

	def add_to_history
	  session[:history] ||= []
 	  session[:history].unshift({"url" => @request.request_uri, "name" => self.controller_name + ":" + self.action_name})
	  session[:history].pop while session[:history].length > 11
	end

	def paginate_collection(collection, options = {})
	  default_options = {:per_page => 30, :page => 1}
	  options = default_options.merge options
	
  	  pages = Paginator.new self, collection.size, options[:per_page], options[:page]
	  first = pages.current.offset
	  last = [first + options[:per_page], collection.size].min
	  slice = collection[first...last]
	  return [pages, slice]
	end

	def hash_to_conditions(myparams, allowed)
		@sqlparams = []
		@varparams = []
		@result = [];
		for param in allowed
			if myparams[param]
				@sqlparams.push("#{param} = ?")
				@varparams.push(myparams[param].strip)
			end
		end
		@result.push(@sqlparams.join(" AND "))
		@result.push(@varparams)
		if @sqlparams.empty?
				@result = []
		end
		return @result
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
	$PICTURE_ADDED = 12
	$EVENT_ORG_PENDING = 13
	$EVENT_ORG_APPROVED = 14
	$EVENT_ORG_REJECTED = 15
	$EVENT_ORG_ACTIVE = 16
	$EVENT_ORG_INACTIVE = 17
	$ORG_PENDING = 1
	$ORG_APPROVED = 2
	$ORG_REJECTED = 3
	$ORG_ACTIVE = 4
	$ORG_INACTIVE = 5
end
