class VolunteerController < ApplicationController
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
    if @event.save
      flash[:notice] = "#{@event.event_type.name} successful"
      redirect_to :action => 'list'
    else
      flash[:error] = "#{@event.event_type.name} failed"
    end
  end

  def list
    @volunteer_pages, @volunteers = paginate :volunteer, :per_page => 20
  end

  def show
    @volunteer = Volunteer.find(params[:id])
  end

  def new
    @volunteer = Volunteer.new
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
    Volunteer.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
