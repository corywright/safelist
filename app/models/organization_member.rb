#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class OrganizationMember < ActiveRecord::Base
	belongs_to :organization
	belongs_to :department
end
