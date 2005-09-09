class PeopleController < ApplicationController
   model :person
   paginate :people, :order_by => 'last_name, first_name', :per_page => 20
  def index
    list
    render :action => 'list'
  end

  def list
    @person_pages, @people = paginate :people, :per_page => 20
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
  end

  def search_tag_id
    #@people = Person.find_by_tag_id(params[:tag_id])
    @people = Person.find(:all, :conditions => [ "tag_id = ?", params[:tag_id]] )
    if @people.nil?
      flash[:notice] = "No one found by that tag id"
      redirect_to :action => "search"
    else
#      @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
#      @shelter = Shelter.find(@person.shelter_id)
      render :action => 'results'
    end
  end

  def search_name
    #@people = Person.find_by_last_name(params[:last_name])
    @people = Person.find(:all, :conditions => [ "last_name ilike ?", params[:last_name]] )
    if @people.nil?
      flash[:notice] = "No one found by that name"
      redirect_to :action => 'search'
    else
      #@pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
      #@shelter = Shelter.find(@person.shelter_id)
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
    if (session[:history][1]['name'] == 'people:show')
	redirect_to :action => 'show', :id => @person.id
    elsif (session[:history][1]['name'] == 'families:show')
	redirect_to :action => 'show', :id => session[:lastfamily], :controller => 'families'
    else
    	redirect_to :action => 'list'
    end
  end
  def destroy
    Person.find(params[:id]).destroy
    if (session[:history][1]['name'] == 'families:show')
       redirect_to :action => 'show', :controller => 'families', :id => session[:lastfamily]
    else
       flash[:notice] = session[:history][1]['name']
       redirect_to :action => 'list'
    end
  end
end
