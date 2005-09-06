class PeopleController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @person_pages, @people = paginate :people, :per_page => 20
  end

  def show
    @person = Person.find(1)
	@pre_disaster_address = Address.find(@person.family.pre_disaster_address_id)
	@shelter = Shelter.find(@person.shelter_id)
  end
  
  def edit
    @person = Person.find(params[:id])
  end
end
