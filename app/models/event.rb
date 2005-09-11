class Event < ActiveRecord::Base
	belongs_to :event_type
	belongs_to :volunteers
	belongs_to :people
        belongs_to :shelter

	def dl_number
	  [@dl_number, @badge_id] = self.notes
	  write_attribute('dl_number', @dl_number);
	end 
	def badge_id
	  [@dl_number, @badge_id] = self.notes
	  write_attribute('badge_id', @badge_id);
	end 
end

