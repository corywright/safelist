class NotesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @note_pages, @notes = paginate :note, :per_page => 10
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
    @volunteer = Volunteer.find(params[:volunteer_id]) if params[:volunteer_id]
    @department = Department.find(params[:department_id]) if params[:department_id]
    @organization = Organization.find(params[:organization_id]) if params[:organization_id]
    @organization_member = OrganizationMember.find(params[:organization_member_id]) if params[:organization_member_id]
    @person = Person.find(params[:person_id]) if params[:person_id]
    @shelter = Shelter.find(params[:shelter_id]) if params[:shelter_id]
    @family = Family.find(params[:family_id]) if params[:family_id]
    @injury_report = InjuryReport.find(params[:injury_report_id]) if params[:injury_report_id]
  end

  def create
    @note = Note.new(params[:note])
    if params[:volunteer]
      @volunteer = Volunteer.find(params[:volunteer][:id])
      @note.volunteers.push @volunteer
    end
    if params[:department]
      @department = Department.find(params[:department][:id])
      @note.departments.push @department
    end
    if params[:organization]
      @organization = Organization.find(params[:organization][:id])
      @note.organizations.push @organization
    end
    if params[:organization_member]
      @organization_member = OrganizationMember.find(params[:organization_member][:id])
      @note.organization_members.push @organization_member
    end
    if params[:person]
      @person = Person.find(params[:person][:id])
      @note.people.push @person
    end
    if params[:shelter]
      @shelter = Shelter.find(params[:shelter][:id])
      @note.shelters.push @shelter
    end
    if params[:family]
      @family = Family.find(params[:family][:id])
      @note.families.push @family
    end
    if params[:injury_report]
      @injury_report = InjuryReport.find(params[:injury_report][:id])
      @note.injury_reports.push @injury_report
    end
    if @note.save
      flash[:notice] = 'Note was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:notice] = 'Note was successfully updated.'
      redirect_to :action => 'show', :id => @note
    else
      render :action => 'edit'
    end
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
