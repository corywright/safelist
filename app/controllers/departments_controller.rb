class DepartmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @departments_pages, @departments = paginate :departments, :per_page => 10
  end

  def show
    @departments = Departments.find(params[:id])
  end

  def new
    @departments = Departments.new
  end

  def create
    @departments = Departments.new(params[:departments])
    if @departments.save
      flash[:notice] = 'Departments was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @departments = Departments.find(params[:id])
  end

  def update
    @departments = Departments.find(params[:id])
    if @departments.update_attributes(params[:departments])
      flash[:notice] = 'Departments was successfully updated.'
      redirect_to :action => 'show', :id => @departments
    else
      render :action => 'edit'
    end
  end

  def destroy
    Departments.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
