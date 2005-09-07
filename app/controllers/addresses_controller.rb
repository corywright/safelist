class AddressesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @address_pages, @addresses = paginate :address, :per_page => 10
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    if @address.save
      flash[:notice] = 'Address was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(params[:address])
      flash[:notice] = 'Address was successfully updated.'
      redirect_to :action => 'show', :id => @address
    else
      render :action => 'edit'
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
