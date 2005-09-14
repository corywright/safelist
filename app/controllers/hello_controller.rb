#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class HelloController < ApplicationController
    before_filter :login_required
  def index
    @families = Family.count_by_sql("select count(distinct f.id) from families f join people p on(f.id=p.family_id) " +
                                    "where p.shelter_id=" + session[:shelter_id].to_s)
    @people = Person.count(["shelter_id = ?", session[:shelter_id] ])
    @volunteers = Volunteer.count(["shelter_id = ?", session[:shelter_id] ])
    @shelter = Shelter.find(session[:shelter_id])
  end
end
