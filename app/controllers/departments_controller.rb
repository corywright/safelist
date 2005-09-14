class DepartmentsController < ApplicationController
  before_filter :login_required
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
    session[:last_department] = @department.id
    @organization = Organization.find(@department.organization_id)
    @members = OrganizationMember.find_all_by_department_id(@department.id)
    if @members.nil?
      @members = []
    end
    @organization_members_pages, @organization_members = paginate_collection @members, :page => @params[:page]
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
      if session[:history][2]['name'] == 'organizations:show'
        redirect_to :action => 'show', :id => session[:last_organization], :controller => 'organizations'
      else
        redirect_to :action => 'list', :id => session[:last_organization]
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @department = Department.find(params[:id])
    session[:last_department] = @department.id
    @organization = Organization.find(@department.organization_id)
    session[:last_organization] = @organization.id
  end

  def update
    @department = Department.find(params[:id])
    session[:last_department] = @department.id
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
