#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

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
    @address = Address.new(params[:address])
    @address.save

    @shelter = Shelter.new(params[:shelter])
    @shelter.address_id = @address.id

    if @shelter.save
      flash[:notice] = 'Shelter was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
    @address = Address.find(@shelter.address_id)
  end

  def update
    @shelter = Shelter.find(params[:id])
    @address = Address.find(@shelter.address_id)
    if @shelter.update_attributes(params[:shelter]) &&
        @address.update_attributes(params[:address])
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
