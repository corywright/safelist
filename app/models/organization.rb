#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Organization < ActiveRecord::Base
	has_many :departments
	has_many :organization_members
	belongs_to :organization_type
	belongs_to :organization_status
        has_and_belongs_to_many :notes
end
