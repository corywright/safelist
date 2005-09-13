#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class InjuryReport < ActiveRecord::Base
    belongs_to :person
    has_and_belongs_to_many :notes
end
