#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Event < ActiveRecord::Base
	belongs_to :event_type
	belongs_to :volunteers
	belongs_to :people
        belongs_to :shelter
end

