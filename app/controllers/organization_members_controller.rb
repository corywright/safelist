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
    @organization_member = OrganizationMember.new
  end

  def create
    @organization_member = OrganizationMember.new(params[:organization_member])
    @organization_member.organization_id = session[:last_organization]
    if @organization_member.save
      flash[:notice] = 'OrganizationMember was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @organization_members = OrganizationMember.find(params[:id])
  end

  def update
    @organization_members = OrganizationMember.find(params[:id])
    if @organization_members.update_attributes(params[:organization_members])
      flash[:notice] = 'OrganizationMember was successfully updated.'
      redirect_to :action => 'show', :id => @organization_members
    else
      render :action => 'edit'
    end
  end

 def update2
    @departments = Department.find(:all)
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      # this is one sweet block of code.
      @organization.departments.clear
      for department in @departments
        if (@params[department.name])
          @organization.departments<<(department)
        end
      end
      flash[:notice] = 'Organization was successfully updated.'
      redirect_to :action => 'show', :id => @organization
    else
      render :action => 'edit'
    end
  end


  def destroy
    OrganizationMember.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
