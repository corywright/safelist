class PeopleController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @person_pages, @people = paginate :people, :per_page => 20
  end

  def show
    @person = Person.find(params[:id])
    @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
    @shelter = Shelter.find(@person.shelter_id)
  end
  
  def edit
    @person = Person.find(params[:id])
    @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
    @shelter = Shelter.find(@person.shelter_id)
  end

  def search
  end

  def search_tag_id
    @person = Person.find_by_tag_id(params[:tag_id])
    if @person.nil?
      flash[:notice] = "No one found by that tag id"
      redirect_to :action => "search"
    else
      @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
      @shelter = Shelter.find(@person.shelter_id)
      render :action => 'show'
    end
  end

  def search_name
    @person = Person.find_by_last_name(params[:last_name])
    if @person.nil?
      flash[:notice] = "No one found by that name"
      redirect_to :action => 'search'
    else
      @pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
      @shelter = Shelter.find(@person.shelter_id)
      render :action => 'show'
    end
  end
  def checkinout
    @person = Person.find(params[:id])
    @event = Event.new
    if @person.checked_in
      if params[:perm]
        @event.event_type = EventType.find(2)
      else
        @event.event_type =
    else
      @event.event_type = EventType.find(1)
    end
    @event.person_id = @person.id
    @event.event_time = Time.now
    if @event.save
      flash[:notice] = "#{@event.event_type.name} successful"
      redirect_to :action => 'list'
    else
      flash[:error] = "#{@event.event_type.name} failed"
    end
  end
end
