#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class Shelter < ActiveRecord::Base
    belongs_to :address, :class_name =>'Address'
end
