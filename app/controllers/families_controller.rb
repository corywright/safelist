class FamiliesController < ApplicationController
  paginate :people, :order_by => 'last_name, first_name', :per_page => 20
  def index
    list
    render :action => 'list'
  end

  def list
    @family_pages, @families = paginate :family, :per_page => 10
  end

  def show
    session[:lastfamily] = params[:id]
    @family = Family.find(params[:id])
    @people = Person.find(:all, :conditions => [ "family_id = ?", params[:id]] )
    @address = Address.find(@family.pre_disaster_address_id)
    if @people.nil?
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
    @family.pre_disaster_address_id = @address.id
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
    @person = Person.new(params[:person])
    @person.family_id = @family.id
    if @person.save
      flash[:notice] = 'Citizen was successfully created.'
    else
      flash[:error] = 'Could not save Citizen.'
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
    @address.update_attributes(params[:address])
    if @family.update_attributes(params[:family])
      flash[:notice] = 'Family was successfully updated.'
      redirect_to :action => 'show', :id => @family
    else
      render :action => 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.family_id = nil
    if @person.save
      flash[:notice] = 'Family member removed.'
    else
      flash[:error] = 'Could not remove family member.'
    end
    redirect_to :action => 'show', :id => session[:lastfamily]
  end
end
