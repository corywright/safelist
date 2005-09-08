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
     if (@event)
	if @event.event_type.id == 1 || @event.event_type.id == 6
          write_attribute(:checked_in, true)
	else
	  write_attribute(:checked_in, false)
	end
     else
	write_attribute(:checked_in, false)
     end
    end
    
    def age
      ((Date.today - dob)/365.0).floor
    end
    
    def tag_id
      if self[:tag_id] == ''
        @shelter = Shelter.find(self.shelter_id)
        self[:tag_id] = @shelter.tag_id_prefix + self.id.to_s
      end
      return self[:tag_id]
    end
   def toggle_in_or_out(perm, shelter_id)
    @person = Person.find(self.id)
    @event = Event.new
    @event.shelter_id = shelter_id
    @event.event_type = EventType.find(1) # default is checkin when there's no previous record
    # this is fucking ugly, but it's late, I'm tired.
    if (@person.last_event)
      if (@person.last_event.event_type == EventType.find(5))
        @event.event_type = EventType.find(6)
      end
      if (@person.last_event.event_type == EventType.find(1) || @person.last_event.event_type == EventType.find(6))
        if perm == 'true'
          @event.event_type = EventType.find(2)
        else
          @event.event_type = EventType.find(5)
        end
      end
#      if (@person.last_event.event_type == EventType.find(6))
#        @event.event_type = EventType.find(5)
#      end
      if (@person.last_event.event_type == EventType.find(2))
        @event.event_type = EventType.find(1)
      end
    end
    @event.person_id = @person.id
    @event.event_time = Time.now
    @event.save
    return @event
   end

end
