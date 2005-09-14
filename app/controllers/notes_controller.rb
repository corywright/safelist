class NotesController < ApplicationController
    before_filter :login_required
  def index
    list
    render :action => 'list'
  end

  def list
    if params[:volunteer_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :volunteers, :conditions => [ "volunteers.id = ?", params[:volunteer_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:department_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :departments, :conditions => [ "departments.id = ?", params[:department_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:organization_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :organizations, :conditions => [ "organizations.id = ?", params[:organization_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:organization_member_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :organization_members, :conditions => [ "organization_members.id = ?", params[:organization_member_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:person_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :people, :conditions => [ "people.id = ?", params[:person_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:shelter_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :shelters, :conditions => [ "shelters.id = ?", params[:shelter_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:family_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :families, :conditions => [ "families.id = ?", params[:family_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    elsif params[:injury_report_id]
      @note_pages, @notes = paginate_collection Note.find(:all, :include => :injury_reports, :conditions => [ "injury_reports.id = ?", params[:injury_report_id]], :order_by => 'note.created_time desc' ), :page => @params[:page]
    else
      @note_pages, @notes = paginate :note, :per_page => 30
    end
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
