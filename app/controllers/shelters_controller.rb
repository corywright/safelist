class SheltersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @shelter_pages, @shelters = paginate :shelter, :per_page => 10
  end

  def show
    @shelter = Shelter.find(params[:id])
    @address = Address.find(@shelter.address_id)
  end

  def new
    @shelter = Shelter.new
  end

  def create
    @shelter = Shelter.new(params[:shelter])
    if @shelter.save
      flash[:notice] = 'Shelter was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update_attributes(params[:shelter])
      flash[:notice] = 'Shelter was successfully updated.'
      redirect_to :action => 'show', :id => @shelter
    else
      render :action => 'edit'
    end
  end

  def destroy
    Shelter.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
