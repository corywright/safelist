#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class FamiliesController < ApplicationController
    before_filter :login_required
  paginate :people, :order_by => 'last_name, first_name', :per_page => 50
  def index
    list
    render :action => 'new'
  end

  def list
    @family_pages, @families = paginate :family, :per_page => 10
  end

  def show
    session[:lastfamily] = params[:id]
    @family = Family.find(params[:id])
    @members = Person.find(:all, :conditions => [ "family_id = ?", params[:id]], 
                           :include => :shelter )
    @address = Address.find(@family.pre_disaster_address_id)
	if @family.post_disaster_address
	  @postaddress = @family.post_disaster_address
	else
	  @postaddress = Address.new
	end
    if @members.nil?
      flash[:error] = 'No members of this family.'
      render :action => 'members'
    else
      render :action => 'members'
    end
  end

  def new
    @family = Family.new
    @address = Address.new
    @address.save
	@postaddress = Address.new
	@postaddress.save
    @family.pre_disaster_address_id = @address.id
    @family.post_disaster_address_id = @postaddress.id
    @shelters = Shelter.find(:all)
    @family.save
    session[:lastfamily] = @family.id
  end

  def newmember
    @family = Family.find(session[:lastfamily])
    @shelters = Shelter.find(:all)
  end

  def create
    @family = Family.find(params[:id])
    @address = Address.find(@family.pre_disaster_address_id)
    @address.update_attributes(params[:address])
	@postaddress = Address.find(@family.post_disaster_address_id)
    @postaddress.update_attributes(params[:postaddress])
    @family.update_attributes(params[:family])
    if @family.save
      redirect_to :action => 'newmember', :id => @family.id
    else
      render :action => 'new'
    end
  end

  def createmember
    @family = Family.find(session[:lastfamily])
    @shelters = Shelter.find(:all)
	@person = Person.new
	
	if Date.exist?(@params[:dob1i].to_i, @params[:dob2i].to_i, @params[:dob3i].to_i)
      @person.update_attributes(params[:person])
	else
      @person.errors.add("dob", "Invalid date entered.")
	  render_action 'newmember' and return 
	end
    @person.family_id = @family.id
    if @person.save
	  if params[:check_in]
		@person.toggle_in_or_out(params[:perm], session[:shelter_id])
	  end
      flash[:notice] = 'Citizen was successfully created.'
    else
	  render_action 'newmember' and return
    end
    redirect_to :action => 'show', :id => @family.id
  end

  def edit
    session[:lastfamily] = params[:id]
    @family = Family.find(params[:id])
  end

  def update
    @family = Family.find(params[:id])
    @address = Address.find(@family.pre_disaster_address_id)
	if @family.post_disaster_address
	  @postaddress = @family.post_disaster_address
	else
	  @postaddress = Address.new
	end
    @address.update_attributes(params[:address])
	@postaddress.update_attributes(params[:postaddress])
	@family.post_disaster_address_id = @postaddress.id
    if @family.update_attributes(params[:family])
      flash[:notice] = 'Family was successfully updated.'
      redirect_to :action => 'show', :id => @family
    else
      render :action => 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.family_id = 0
    if @person.save
      flash[:notice] = 'Family member removed.'
    else
      flash[:error] = 'Could not remove family member.'
    end
    redirect_to :action => 'show', :id => session[:lastfamily]
  end

  def checkout
	if @params[:postaddress] # they've entered the address
      @people = Person.find_all_by_family_id(params[:id])
      for @person in @people
        if @person.checked_in
          @person.toggle_in_or_out(params[:perm], session[:shelter_id])
        end
      end
	  @family = Family.find(params[:id])
	  if @family.post_disaster_address
	    @postaddress = @family.post_disaster_address
	  else
	    @postaddress = Address.new
   	  end
	  @postaddress.update_attributes(params[:postaddress])
	  @postaddress.save
	  @family.post_disaster_address_id = @postaddress.id
	  @family.save
	  @note = Note.new(params[:note])
	  @note.subject = 'Check Out Notes'
	  @note.families.push(@family)
	  @note.save
      redirect_to :action => 'show', :id => session[:lastfamily]
	else # render to checkout template otherwise
	  @family = Family.find(session[:lastfamily])
      if @family.post_disaster_address
        @postaddress = @family.post_disaster_address
      else
        @postaddress = Address.new
      end
	  @note = Note.new
	end
  end

  def checkin
    @people = Person.find_all_by_family_id(params[:id])
    for @person in @people
      if !@person.checked_in
        @person.toggle_in_or_out(params[:perm], session[:shelter_id])
      end
    end
    redirect_to :action => 'show', :id => session[:lastfamily]
  end

  def search_to_add
    session[:lastfamily] = params[:id]
    @family = Family.find(session[:lastfamily])
    @members = Person.find(:all, :conditions => [ "family_id = ?", params[:id]] )
    if @people.nil?
      flash[:error] = 'No members of this family.'
    end
    render :action => 'search_to_add'
  end

  def addexisting
    @family = Family.find(session[:lastfamily])
    @person = Person.find(params[:id])
    @person.family_id = @family.id
    if @person.save
      flash[:notice] = 'Family member added.'
    else
      flash[:error] = 'Failed to add member.'
    end
    redirect_to :action => 'show', :id => @family.id
  end

  def search_tag_id
    @family = Family.find(session[:lastfamily])
    @members = Person.find(:all, :conditions => [ "family_id = ?", @family.id] )
    @people = Person.find(:all, :conditions => [ "tag_id = ?", params[:tag_id]] )
	if @people.empty?
		@people = Person.find(:all, :conditions => [ "id = ?", params[:tag_id][/[0-9]+/]])
	end
    if @people.nil?
      flash[:notice] = "No one found by that tag id"
      redirect_to :action => "search"
    else
      render :action => 'results'
    end
  end

  def search_name
    @family = Family.find(session[:lastfamily])
    @members = Person.find(:all, :conditions => [ "family_id = ?", @family.id] )
    @person_pages, @people = paginate_collection Person.find(:all, :conditions => [ "last_name ilike ?", params[:last_name].strip + '%'] ), :page => @params[:page], :per_page => 50
    if @people.nil?
      flash[:notice] = "No one found by that name"
      redirect_to :action => 'search'
    else
      render :action => 'results'
    end
  end
  
  def search_ajax
    if @params[:person][:last_name].length > 2 && @params[:person][:first_name].length > 1
	    @people = Person.find(:all, :conditions => [ "last_name ilike ? and first_name ilike ?", params[:person][:last_name].strip + '%', params[:person][:first_name].strip + '%'], :limit => 5 )
	elsif @params[:person][:tag_id].length >= 4
	    @people = Person.find(:all, :conditions => [ "tag_id = ?", params[:person][:tag_id].strip ], :limit => 5 )
	else
		@people = []
    end
	render :action => 'search_ajax', :layout => false
  end
end
