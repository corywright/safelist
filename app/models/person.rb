class Person < ActiveRecord::Base
    belongs_to :family
    belongs_to :person_type
    belongs_to :shelter
    has_many :injury_reports

    validates_presence_of :first_name, :last_name

    def name
      first_name + " " + last_name
    end
    def last_check_in
      @event = Event.find_by_person_id_and_event_type_id(self.id, 1, :order => "event_time DESC")
      write_attribute(:last_check_in, @event.event_time) if @event
    end
    def last_check_out
      @event = Event.find_by_person_id_and_event_type_id(self.id, 2, :order => "event_time DESC")
      write_attribute(:last_check_out, @event.event_time) if @event
    end
    def last_event
      @event = Event.find_by_person_id(self.id, :order => "event_time DESC");
      return @event
    end
    def checked_in
     @event = self.last_event
     if @event.event_type == (1 || 6)
     	write_attribute(:checked_in, true)
     else
        write_attribute(:checked_in, false);
     end
    end
    def age
      ((Date.today - dob)/365.0).floor
    end
    
end
