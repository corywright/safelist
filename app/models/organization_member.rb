#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationMember < ActiveRecord::Base
	belongs_to :organization
	belongs_to :department
    has_and_belongs_to_many :notes

  def last_check_in
      @event = Event.find_by_organization_member_id_and_event_type_id(self.id, 10, :order => "event_time DESC")
      write_attribute(:last_check_in, @event.event_time) if @event
  end
  def last_check_out
      @event = Event.find_by_organization_member_id_and_event_type_id(self.id, 11, :order => "event_time DESC")
      write_attribute(:last_check_out, @event.event_time) if @event
  end
  def last_event
      Event.find_by_organization_member_id(self.id, :order => "event_time DESC");
  end
  def checked_in
    if self.last_check_in
      if (self.last_check_in.to_i > self.last_check_out.to_i)
        write_attribute(:checked_in, true)
      else
        write_attribute(:checked_in, false)
      end
    else
        # never logged in
        write_attribute(:checked_in, false)
    end
  end

end
