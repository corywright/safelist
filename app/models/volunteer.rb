class Volunteer < ActiveRecord::Base
  has_many :events
 
  def last_check_in
      @event = Event.find_by_volunteer_id_and_event_type_id(self.id, 3, :order => "event_time")
      write_attribute(:last_check_in, @event.event_time) if @event
  end
  def last_check_out
      @event = Event.find_by_volunteer_id_and_event_type_id(self.id, 4, :order => "event_time")
      write_attribute(:last_check_out, @event.event_time) if @event
  end
  def last_event
      Event.find_by_volunteer_id(self.id, :order => "event_time");
  end
  def checked_in
      if (self.last_check_in > self.last_check_out)
      	write_attribute(:checked_in, true)
      else
      	write_attribute(:checked_out, false)
      end
  end
  protected
    def validate
      errors.add_on_empty %w( first_name last_name )
      errors.add("home_phone", "has invalid format") unless home_phone =~ /[0-9]*/
    end

    def validate_on_update
      errors.add_to_base("No changes have occurred") if unchanged_attributes?
    end
end
