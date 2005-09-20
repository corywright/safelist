#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationMember < ActiveRecord::Base
  belongs_to :organization
  belongs_to :department
  has_and_belongs_to_many :notes

  def last_check_in_event
    Event.find_by_organization_member_id_and_event_type_id(self.id, 10, :order => "event_time DESC")
  end
  def last_check_out_event
    Event.find_by_organization_member_id_and_event_type_id(self.id, 11, :order => "event_time DESC")
  end
  def last_event
    Event.find_by_organization_member_id(self.id, :order => "event_time DESC");
  end
  def checked_in
    if self.last_check_in_event and self.last_check_out_event
      (self.last_check_in_event.event_time > self.last_check_out_event.event_time) ? true : false
    else
      (self.last_check_in_event) ? true : false
    end
  end

end
