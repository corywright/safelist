#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationsController < ApplicationController
    before_filter :login_required
  paginate :organizations, :order_by => 'name', :per_page => 30
  paginate :departments, :order_by => 'name', :per_page => 30
  def index
    list
    render :action => 'list'
  end

  def list
    @organization_pages, @organizations = paginate_collection Organization.find(:all, :include => :organization_status), :page => params[:page]
  end

  def show
    @departments = Department.find(:all)
    @organization = Organization.find(params[:id])
    session[:last_organization] = @organization.id
    @organization_members_pages, @organization_members = paginate_collection OrganizationMember.find(:all, :conditions => ['organization_members.organization_id = ?', @organization.id], :include => :department), :page => @params[:page]
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
    @organization.organization_status_id = $ORG_PENDING
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
    session[:last_organization] = @organization.id
    @address = Address.find(@organization.address_id);
  end

  def update
    @organization = Organization.find(params[:id])
    session[:last_organization] = @organization.id
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
