#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Address < ActiveRecord::Base
    belongs_to :shelters
    belongs_to :people
    belongs_to :families
end
