class DepartmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @department_pages, @departments = paginate :department, :per_page => 10
  end

  def show
    @department = Department.find(params[:id])
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      flash[:notice] = 'Department was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(params[:department])
      flash[:notice] = 'Department was successfully updated.'
      redirect_to :action => 'show', :id => @department
    else
      render :action => 'edit'
    end
  end

  def destroy
    Department.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
