#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @organization_pages, @organizations = paginate :organization, :per_page => 10
  end

  def show
    @departments = Department.find(:all)
    @organization = Organization.find(params[:id])
    @address = Address.find(@organization.address_id);
  end

  def new
    @organization_types = OrganizationType.find(:all)
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    @address = Address.new(params[:address])
    @address.save
    @organization.address_id = @address.id
    if @organization.save
      flash[:notice] = 'Organization was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @departments = Department.find(:all)
    @organization_types = OrganizationType.find(:all)
    @organization = Organization.find(params[:id])
    @address = Address.find(@organization.address_id);
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      flash[:notice] = 'Organization was successfully updated.'
      redirect_to :action => 'show', :id => @organization
    else
      render :action => 'edit'
    end
  end

#  def destroy
#    Organization.find(params[:id]).destroy
#    redirect_to :action => 'list'
#  end
end
