#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Person < ActiveRecord::Base
    belongs_to :family
    belongs_to :person_type
    belongs_to :shelter
    belongs_to :ethnicity
    belongs_to :badge_status
    has_many :injury_reports
	has_one :picture
    has_and_belongs_to_many :notes

    validates_presence_of :first_name, :last_name

    def name
      first_name + " " + last_name
    end

	def first_name
	  tmp = []
	  self[:first_name].split.each { |b| tmp.push(b.downcase.capitalize) }
	  name = tmp.join(' ')
	  write_attribute('first_name', name)
	end
	def last_name
	  tmp = []
	  self[:last_name].split.each { |b| tmp.push(b.downcase.capitalize) }
	  name = tmp.join(' ')
	  write_attribute('last_name', name)
	end
	
    def last_check_in_event
      @event = Event.find_by_person_id_and_event_type_id(self.id, $CITIZEN_CHECKIN, :order => "event_time DESC")
      @temp_event = Event.find_by_person_id_and_event_type_id(self.id, $CITIZEN_TEMPRETURN, :order => "event_time DESC")
      if @event and @temp_event
        (@event.event_time > @temp_event.event_time) ? @event : @temp_event
      elsif @temp_event and @event.nil?
        @temp_event
      elsif @event and @temp_event.nil?
        @event
      end
    end
    def last_check_out_event
      @event = Event.find_by_person_id_and_event_type_id(self.id, $CITIZEN_CHECKOUT, :order => "event_time DESC")
      @temp_event = Event.find_by_person_id_and_event_type_id(self.id, $CITIZEN_TEMPOUT, :order => "event_time DESC")
      if @event and @temp_event
        (@event.event_time > @temp_event.event_time) ? @event : @temp_event
      elsif @temp_event and @event.nil?
        @temp_event
      elsif @event and @temp_event.nil?
        @event
      end
    end
    def last_event
      Event.find_by_person_id(self.id, :order => "event_time DESC");
    end
    
    def checked_in
      if self.last_check_in_event and self.last_check_out_event
        (self.last_check_in_event.event_time > self.last_check_out_event.event_time) ? true : false
      else
        (self.last_check_in_event) ? true : false
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

    if @person.checked_in
      if perm == 'true'
        @event.event_type_id = $CITIZEN_CHECKOUT
      else
        @event.event_type_id = $CITIZEN_TEMPOUT
      end
    else
      if @person.last_check_out_event and @person.last_check_out_event.event_type_id = $CITIZEN_TEMPOUT
        @event.event_type_id = $CITIZEN_TEMPRETURN
      else
        @event.event_type_id = $CITIZEN_CHECKIN
      end
    end

    @event.person_id = @person.id
    @event.event_time = Time.now
    @event.save
    return @event
  end

   def ssn
		if self[:ssn].length > 0
			newssn = self[:ssn].gsub(/[^0-9]/, "")
			last4 = newssn[newssn.length - 4, 4]
			write_attribute(:ssn, 'XXX-XX-' + last4)
		else
			write_attribute(:ssn, '')
		end
   end
   def realssn
		@p = Person.find(self.id)
		write_attribute(:realssn, @p[:ssn].gsub(/[^0-9]/, ""))
   end
end
