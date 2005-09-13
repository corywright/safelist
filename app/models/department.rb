#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Department < ActiveRecord::Base
	has_many :organization_members
	belongs_to :organization
	has_and_belongs_to_many :notes
end
