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
    if @people.nil?
      flash[:error] = 'No members of this family.'
    else
      render :action => 'members'
    end
  end

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(params[:family])
    if @family.save
      flash[:notice] = 'Family was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    session[:lastfamily] = params[:id]
    @family = Family.find(params[:id])
  end

  def update
    @family = Family.find(params[:id])
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
