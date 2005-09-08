class HelloController < ApplicationController
  def index
    @families = Family.count_by_sql("select count(*) from people p, families f where " +
                                    "p.family_id=f.id and p.shelter_id=" + session[:shelter_id].to_s)
    @people = Person.count(["shelter_id = ?", session[:shelter_id] ])
    @volunteers = Volunteer.count(["shelter_id = ?", session[:shelter_id] ])
    @shelter = Shelter.find(session[:shelter_id])
  end
end
