class DepartmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    if @params[:id]
      @organization = Organization.find(params[:id])
      session[:last_organization] = @organization.id
      @department_pages, @departments = paginate_collection Department.find_all_by_organization_id(params[:id]), :per_page => 20
    else
      @department_pages, @departments = paginate_collection Department.find(:all), :per_page => 20
    end

  end

  def show
    @department = Department.find(params[:id])
    @organization = Organization.find(@department.organization_id)
    session[:last_organization] = @organization.id
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    @department.organization_id = session[:last_organization]
    if @department.save
      flash[:notice] = 'Department was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @department = Department.find(params[:id])
    @organization = Organization.find(@department.organization_id)
    session[:last_organization] = @organization.id
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
      flash[:notice] = 'Department was successfully updated.'
      redirect_to :action => 'show', :id => @department
    else
      render :action => 'edit', :id => params[:id]
    end
  end

#  def destroy
#    Department.find(params[:id]).destroy
#    redirect_to :action => 'list'
#  end
end
