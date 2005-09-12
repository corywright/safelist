#
# This file is part of the SafeList shelter management software.
# Copyright 2005, Rackspace Managed Hosting
#

class RegisterController < ApplicationController

    def index
        setup
        @shelters = Shelter.find(:all)
        @person = Person.new()
        rescue 
            error_handler
    end
    def new_person_handler
        setup
        session[:registration][:people] << params[:person]
    
        if params[:next] == "Add Another Person"
            action = "index"
        else
            action = "summary"
        end
        flash[:notice] = "Person Added"
        redirect_to :action => action
        rescue 
            error_handler
    end
    def edit_person
        setup
        @person = Person.new(session[:registration][:people][params[:id].to_i])
        @id = params[:id]
		@shelters = Shelter.find(:all)
        rescue 
            error_handler
    end
    def update_person
        setup
        session[:registration][:people][params[:id].to_i] = params[:person]
        redirect_to :action => "summary"
        rescue 
            error_handler
    end
    def destroy_person
        setup
        session[:registration][:people][params[:id].to_i] = nil
        session[:registration][:people].compact!
        redirect_to :action => "summary"
        rescue 
            error_handler

    end
    def summary
        @people = session[:registration][:people]
        rescue 
            error_handler
    end
    def submit
        setup
        if session[:registration][:people].length > 0
            # Create address
            @address = Address.new(params[:address])
            @address.save!
            # Create family
            @family = Family.new()
            if params[:disclosure_consent] == "t" 
                @family.disclosure_consent = true
            end
            @family.pre_disaster_address = @address
            @family.save!
            # Create people
	    family_shelter_id = 0
            for person in session[:registration][:people]
                @person = Person.new(person)
                @person.family = @family
		@shelter = Shelter.find(person[:shelter_id])
		family_shelter_id = person[:shelter_id]
                if person[:location_description].nil? ||
                 person[:location_description] == ""
                    @person.shelter = @shelter
                end
                @type = PersonType.find(person[:person_type_id])
                @person.person_type = @type
                @person.save
            end
            session[:registration] = nil
            redirect_to :action => "thank_you",:id => @family
        else
            redirect_to :action => "index"
        end 
        rescue 
            error_handler
    end
    def thank_you
        @family = Family.find(params[:id])
        @people = @family.people
        @address = @family.pre_disaster_address
        @person = @people[0]
        @shelter = Shelter.find(@person.shelter_id)
        rescue 
            error_handler
    end
    def error_handler
        redirect_to :action => "error"
    end
    def error
        logger.error("Problem with the registration process")
    end
    def setup
        session[:registration] ||= {}
        session[:registration][:people] ||= []
    end
    protected :setup

end
