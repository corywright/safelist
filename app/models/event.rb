class Event < ActiveRecord::Base
	belongs_to :event_type
	belongs_to :volunteers
	belongs_to :people
        belongs_to :shelter
	serialize :notes
	# so we can store ruby objs in the notes field

	def dl_number
	  write_attribute(:dl_number, self.notes[:dl_number]) if self.notes[:dl_number];
	end 
	def badge_id
	  write_attribute(:badge_id, self.notes[:badge_id]) if self.notes[:badge_id];
	end 
end

