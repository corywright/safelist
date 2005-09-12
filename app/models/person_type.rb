#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class PersonType < ActiveRecord::Base
    has_many :people
end
