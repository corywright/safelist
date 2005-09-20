#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Volunteer < ActiveRecord::Base
  has_many :events
  belongs_to :shelter
  has_and_belongs_to_many :notes

  def name
      first_name + " " + last_name
  end

  def last_check_in_event
      Event.find_by_volunteer_id_and_event_type_id(self.id, $VOLUNTEER_CHECKIN, :order => "event_time DESC")
  end
  def last_check_out_event
      Event.find_by_volunteer_id_and_event_type_id(self.id, $VOLUNTEER_CHECKOUT, :order => "event_time DESC")
  end
  def last_event
      Event.find_by_volunteer_id(self.id, :order => "event_time DESC");
  end
  def checked_in
    if self.last_check_in_event and self.last_check_out_event
      (self.last_check_in_event.event_time > self.last_check_out_event.event_time) ? true : false
    else
      (self.last_check_in_event) ? true : false
    end
  end
  protected
    def validate
      errors.add_on_empty %w( first_name last_name )
      errors.add("home_phone", "has invalid format") unless home_phone =~ /[0-9]*/
    end

end
