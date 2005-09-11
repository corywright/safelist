class PeopleController < ApplicationController
   model :person
   paginate :people, :order_by => 'last_name, first_name', :per_page => 20
  def index
    list
    render :action => 'list'
  end

  def list
    @order = 'last_name ASC'
    if (params[:sort] && params[:order])
      @order = params[:sort] + ' ' + params[:order]
    end
    @person_pages, @people = paginate :people, :per_page => 30, :order_by => @order

    @shelter_map = {}
    @shelters = Shelter.find(:all)
    for shelter in @shelters
      @shelter_map[shelter.id] = shelter.name
    end
  end

  def show
    @person = Person.find(params[:id], :include => :person_type)
    @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
    @shelter = Shelter.find(@person.shelter_id)
    @events = Event.find_all_by_person_id(params[:id],
                                          :include => [:event_type, :shelter],
                                          :order => "event_time DESC",
					  :limit => 20)
  end
  
  def printlist
    @people = Person.find(:all, :include => :shelter, :order => "last_name, first_name")
  end

  def edit
    @person = Person.find(params[:id])
    @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
    @shelters = Shelter.find(:all)
    @shelter = Shelter.find(@person.shelter_id)
  end

  def new
    @person = Person.new
    @shelters = Shelter.find(:all)
  end

  def create
    @shelters = Shelter.find(:all)
    @person = Person.new(params[:person])
    if (session[:history][2]["url"] =~ /families/)
	@person.family_id = session[:lastfamily]
	added_to_family = 1
    end
    if @person.save
      flash[:notice] = 'Citizen was successfully created.'
    else
      flash[:error] = 'Could not save Citizen.'
    end
    if added_to_family
      redirect_to :action => 'show', :controller => 'families', :id => @person.family_id
    else
      redirect_to :action => 'list'
    end
  end

  def update
   @person = Person.find(params[:id])
   if @person.update_attributes(params[:person])
     flash[:notice] = 'Citizen was successfully updated.'
     redirect_to :action => 'show', :id => @person
   else
    render :action => 'edit'
   end
  end

  def search
    @shelters = Shelter.find(:all)
  end

  def search_tag_id
    @people = Person.find(:all,
                          :conditions => [ "tag_id ilike ?", params[:tag_id].strip+'%'],
                          :include => :shelter)
    if @people.nil?
      flash[:notice] = "No one found by that tag id"
      redirect_to :action => "search"
    else
      render :action => 'results'
    end
  end

  def search_fema_reg_id
    @people = Person.find(:all, 
                          :conditions => [ "fema_reg_id ilike ?", params[:fema_reg_id].strip+'%'],
                          :include => :shelter)
    if @people.nil?
      flash[:notice] = "No one found by that FEMA Registration ID"
      redirect_to :action => "search"
    else
      render :action => 'results'
    end
  end

  # badge_id is the debit_id/bracelet_id
  def search_fema_bracelet_id
    @people = Person.find(:all, 
                          :conditions => [ "debit_id ilike ?", params[:fema_bracelet_id].strip+'%'],
                          :include => :shelter)
    if @people.nil?
      flash[:notice] = "No one found by that FEMA Bracelet ID"
      redirect_to :action => "search"
    else
      render :action => 'results'
    end
  end

  def search_name
    if params[:first_name] != ""
      if params[:last_name].length < 4
        flash[:notice] = 'Search string must be at least 4 characters.'
        redirect_to :action => 'search' and return
      else
        @people = Person.find(:all, 
                          :conditions => [ "first_name ilike ?", params[:first_name].strip + '%'],
                          :order => 'last_name, first_name', :include => :shelter)
      end
    else
      if params[:last_name].length < 4
        flash[:notice] = 'Search string must be at least 4 characters.'
        redirect_to :action => 'search' and return
      else
        @people = Person.find(:all, 
                          :conditions => [ "last_name ilike ?", params[:last_name].strip + '%'],
                          :order => 'last_name, first_name', :include => :shelter)
      end
    end
    if @people.nil?
      flash[:notice] = "No one found by that name"
      redirect_to :action => 'search'
    else
      render :action => 'results'
    end
  end
  def checkinout
    @person = Person.find(params[:id])
    @event = @person.toggle_in_or_out(params[:perm], session[:shelter_id])
    if @event
      flash[:notice] = "#{@event.event_type.name} successful"
    else
      flash[:error] = "#{@event.event_type.name} failed"
    end
    if (session[:history][1]['name'] == 'people:show' || session[:history][1]['name'] == "people:list")
	redirect_to :action => 'show', :id => @person.id
    elsif (session[:history][1]['name'] == 'families:show')
	redirect_to :action => 'show', :id => session[:lastfamily], :controller => 'families'
    else
    	redirect_to :action => 'list'
    end
  end
  def destroy
  #  Person.find(params[:id]).destroy
    if (session[:history][1]['name'] == 'families:show')
       redirect_to :action => 'show', :controller => 'families', :id => session[:lastfamily]
    else
       flash[:notice] = session[:history][1]['name']
       redirect_to :action => 'list'
    end
  end
end
