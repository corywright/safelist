#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationStatusController< ApplicationController
  def approve
  	@organization = Organization.find(params[:id])
	@organization.organization_status_id = $ORG_APPROVED
	if @organization.save
		@event = Event.new
		@event.event_type = EventType.find($EVENT_ORG_APPROVED)
		@event.event_time = Time.now
		@event.organization_id = @organization.id
		@event.save
		flash[:notice] = "Organization status set to #{@organization.organization_status.name}"
	else
		flash[:error] = "Setting Organization status failed"
	end
	redirect_to :controller => 'organizations', :action => 'show', :id => @organization.id
  end

  def pend
  	@organization = Organization.find(params[:id])
	@organization.organization_status_id = $ORG_PENDING
	if @organization.save
		@event = Event.new
		@event.event_type = EventType.find($EVENT_ORG_PENDING)
		@event.event_time = Time.now
		@event.organization_id = @organization.id
		@event.save
		flash[:notice] = "Organization status set to #{@organization.organization_status.name}"
	else
		flash[:error] = "Setting Organization status failed"
	end
	redirect_to :controller => 'organizations', :action => 'show', :id => @organization.id
  end

  def deny
  	@organization = Organization.find(params[:id])
	@organization.organization_status_id = $ORG_REJECTED
	if @organization.save
		@event = Event.new
		@event.event_type = EventType.find($EVENT_ORG_REJECTED)
		@event.event_time = Time.now
		@event.organization_id = @organization.id
		@event.save
		flash[:notice] = "Organization status set to #{@organization.organization_status.name}"
	else
		flash[:error] = "Setting Organization status failed"
	end
	redirect_to :controller => 'organizations', :action => 'show', :id => @organization.id
  end

  def active
  	@organization = Organization.find(params[:id])
	@organization.organization_status_id = $ORG_ACTIVE
	if @organization.save
		@event = Event.new
		@event.event_type = EventType.find($EVENT_ORG_ACTIVE)
		@event.event_time = Time.now
		@event.organization_id = @organization.id
		@event.save
		flash[:notice] = "Organization status set to #{@organization.organization_status.name}"
	else
		flash[:error] = "Setting Organization status failed"
	end
	redirect_to :controller => 'organizations', :action => 'show', :id => @organization.id
  end

  def inactive
  	@organization = Organization.find(params[:id])
	@organization.organization_status_id = $ORG_INACTIVE
	if @organization.save
		@event = Event.new
		@event.event_type = EventType.find($EVENT_ORG_INACTIVE)
		@event.event_time = Time.now
		@event.organization_id = @organization.id
		@event.save
		flash[:notice] = "Organization status set to #{@organization.organization_status.name}"
	else
		flash[:error] = "Setting Organization status failed"
	end
	redirect_to :controller => 'organizations', :action => 'show', :id => @organization.id
  end

end
