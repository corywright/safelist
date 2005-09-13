#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

# The filters added to this controller will be run for all controllers in the application.
# Likewise will all the methods added be available for all controllers.
class ApplicationController < ActionController::Base
	before_filter :authorize
	before_filter :add_to_history
	before_filter :get_shelter

	def add_to_history
	  session[:history] ||= []
 	  session[:history].unshift({"url" => @request.request_uri, "name" => self.controller_name + ":" + self.action_name})
	  session[:history].pop while session[:history].length > 11
	end

	def get_shelter
	  if !session[:shelter_id]
	    @shelter = Shelter.find_by_domain(session[:user])
	    if @shelter
	      session[:shelter_id] = @shelter.id
	    else
	      session[:shelter_id] = 1
	    end
	  end
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

  def authorize(realm='SASafelist', errormessage="Your username and password could not be verified, please email help@sasafelist.org") 
    username, passwd = get_auth_data 
    # check if authorized 
    # try to get user 
    if user = User.authenticate(username, passwd) 
      # user exists and password is correct ... horray! 
      if user.methods.include? 'lastlogin' 
        # note last login 
        session['lastlogin'] = user.lastlogin 
        user.last.login = Time.now 
        user.save() 
      session["user.id"] = user.id 
      session["user"] = user.username
      end             
    else 
      # the user does not exist or the password was wrong 
      response.headers["Status"] = "Unauthorized" 
      response.headers["WWW-Authenticate"] = "Basic realm=\"#{realm}\"" 
      render :text => errormessage, :status => 401       
    end 
  end 

  def get_auth_data 
    user, pass = '', '' 
    # extract authorisation credentials 
    if request.env.has_key? 'X-HTTP_AUTHORIZATION' 
      # try to get it where mod_rewrite might have put it 
      authdata = request.env['X-HTTP_AUTHORIZATION'].to_s.split 
    elsif request.env.has_key? 'Authorization' 
      # for Apace/mod_fastcgi with -pass-header Authorization 
      authdata = request.env['Authorization'].to_s.split 
    elsif request.env.has_key? 'HTTP_AUTHORIZATION' 
      # this is the regular location 
      authdata = request.env['HTTP_AUTHORIZATION'].to_s.split  
    end 

    # at the moment we only support basic authentication 
    if authdata and authdata[0] == 'Basic' 
      user, pass = Base64.decode64(authdata[1]).split(':')[0..1] 
    end 
    return [user, pass] 
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
	$EVENT_ORG_PENDING = 12
	$EVENT_ORG_APPROVED = 13
	$EVENT_ORG_REJECTED = 14
	$EVENT_ORG_ACTIVE = 15
	$EVENT_ORG_INACTIVE = 16
	$ORG_PENDING = 1
	$ORG_APPROVED = 2
	$ORG_REJECTED = 3
	$ORG_ACTIVE = 4
	$ORG_INACTIVE = 5
end
