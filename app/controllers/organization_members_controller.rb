#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationMembersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @organization_members_pages, @organization_members = paginate :organization_members, :per_page => 10
  end

  def show
    @organization_members = OrganizationMember.find(params[:id])
  end

  def new
    @departments = Department.find(:all)
    @organization_member = OrganizationMember.new
  end

  def create
    @organization_member = OrganizationMember.new(params[:organization_member])
    @organization_member.organization_id = session[:last_organization]
    if @organization_member.save
      flash[:notice] = 'OrganizationMember was successfully created.'
      if session[:history][2]['name'] == 'organizations:show'
        redirect_to :action => 'show', :id => session[:last_organization], :controller => 'organizations'
      else
        redirect_to :action => 'list'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @departments = Department.find(:all)
    @organization_members = OrganizationMember.find(params[:id])
  end

  def update
    @organization_member = OrganizationMember.find(params[:id])
    if @organization_member.update_attributes(params[:organization_member])
      flash[:notice] = 'OrganizationMember was successfully updated.'
      redirect_to :action => 'show', :id => @organization_member
    else
      render :action => 'edit'
    end
  end

  def destroy
    OrganizationMember.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
