class Event < ActiveRecord::Base
	belongs_to :event_type
	belongs_to :volunteers
	belongs_to :people
end

