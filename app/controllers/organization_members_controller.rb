class OrganizationMembersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @organization_members_pages, @organization_members = paginate :organization_members, :per_page => 10
  end

  def show
    @organization_members = OrganizationMembers.find(params[:id])
  end

  def new
    @organization_members = OrganizationMembers.new
  end

  def create
    @organization_members = OrganizationMembers.new(params[:organization_members])
    if @organization_members.save
      flash[:notice] = 'OrganizationMembers was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @organization_members = OrganizationMembers.find(params[:id])
  end

  def update
    @organization_members = OrganizationMembers.find(params[:id])
    if @organization_members.update_attributes(params[:organization_members])
      flash[:notice] = 'OrganizationMembers was successfully updated.'
      redirect_to :action => 'show', :id => @organization_members
    else
      render :action => 'edit'
    end
  end

  def destroy
    OrganizationMembers.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
