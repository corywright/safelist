class VolunteerController < ApplicationController
  paginate :volunteers, :order_by => 'last_name, first_name', :per_page => 40, :order_by => "last_name"
  def index
    list
    render :action => 'list'
  end

  def checkinout
    @volunteer = Volunteer.find(params[:id])
    @event = Event.new
    @event.shelter_id = session[:shelter_id]
    if @volunteer.checked_in
      @event.event_type = EventType.find(4)
    else
      @event.event_type = EventType.find(3)
    end
    @event.volunteer_id = @volunteer.id
    @event.event_time = Time.now
    @event.notes = params[:badge_id]
    if @event.save
      flash[:notice] = "#{@event.event_type.name} successful"
      redirect_to :action => 'list'
    else
      flash[:error] = "#{@event.event_type.name} failed"
    end
  end

  def checkin_notes
    @volunteer = Volunteer.find(params[:id], :include => :shelter)
    @shelters = Shelter.find(:all)
  end

  def printlist
    @volunteers = Volunteer.find(:all, :include => :shelter, :order => "last_name, first_name")
  end

  def list
    @shelters = Shelter.find(:all)
    if params[:shelter_id]
      @volunteer_pages, @volunteers = paginate_collection Volunteer.find(:all, :conditions => [ "shelter_id = ?", params[:shelter_id] ], :order_by => 'last_name' ), :page => @params[:page]
    else
      @volunteer_pages, @volunteers = paginate :volunteer, :per_page => 30, :order_by => "last_name"
    end
  end

  def show
    @volunteer = Volunteer.find(params[:id], :include => :shelter)
    @events = Event.find_all_by_volunteer_id(params[:id],
                                             :include => [:event_type, :shelter],
                                             :order => "event_time DESC",
					     :limit => 10)
  end

  def new
    @volunteer = Volunteer.new
    @volunteer.shelter_id = session[:shelter_id]
    @shelters = Shelter.find(:all)
  end

  def create
    @volunteer = Volunteer.new(params[:volunteer])
    if @volunteer.save
      flash[:notice] = 'Volunteer was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @volunteer = Volunteer.find(params[:id])
    @shelters = Shelter.find(:all)
  end

  def update
    @volunteer = Volunteer.find(params[:id])
    if @volunteer.update_attributes(params[:volunteer])
      flash[:notice] = 'Volunteer was successfully updated.'
      redirect_to :action => 'show', :id => @volunteer
    else
      render :action => 'edit'
    end
  end

  def destroy
#    Volunteer.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def search_name
    search_name = params[:name].strip
    if search_name.length < 1
      flash[:notice] = 'Search string must be at least 1 character.'
      redirect_to :action => 'list' and return
    else
      search_name = search_name + '%'
      @volunteers = Volunteer.find(:all,
                                   :conditions => [ 
                                     "first_name ilike ? or last_name ilike ?", 
                                     search_name, 
                                     search_name
                                   ],
                                   :order => 'last_name, first_name', 
                                   :include => :shelter)
    end
    if @volunteers.nil?
      flash[:notice] = "No one found by that name"
      redirect_to :action => 'list'
    else
      # if there is only one, show that person's information
      if @volunteers.length == 1
        redirect_to :action => 'show', :id => @volunteers[0].id
      else
        render :action => 'results'
      end
    end
  end

end
