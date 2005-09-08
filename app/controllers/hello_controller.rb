class HelloController < ApplicationController
  def index
    @families = Family.count
    @people = Person.count
    @volunteers = Volunteer.count
  end
end
