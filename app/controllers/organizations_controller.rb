class OrganizationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @organizations_pages, @organizations = paginate :organizations, :per_page => 10
  end

  def show
    @organizations = Organizations.find(params[:id])
  end

  def new
    @organizations = Organizations.new
  end

  def create
    @organizations = Organizations.new(params[:organizations])
    if @organizations.save
      flash[:notice] = 'Organizations was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @organizations = Organizations.find(params[:id])
  end

  def update
    @organizations = Organizations.find(params[:id])
    if @organizations.update_attributes(params[:organizations])
      flash[:notice] = 'Organizations was successfully updated.'
      redirect_to :action => 'show', :id => @organizations
    else
      render :action => 'edit'
    end
  end

  def destroy
    Organizations.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
