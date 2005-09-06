class Event < ActiveRecord::Base
	belongs_to :volunteers
	belongs_to :people
end

