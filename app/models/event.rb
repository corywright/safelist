class Event < ActiveRecord::Base
	has_one    :event_type
	belongs_to :volunteers
	belongs_to :people
end

