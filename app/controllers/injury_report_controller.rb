class InjuryReportController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @injury_report_pages, @injury_reports = paginate :injury_report, :per_page => 10
  end

  def show
    @injury_report = InjuryReport.find(params[:id])
  end

  def new
    @injury_report = InjuryReport.new
    @injury_report.person_id = params[:id]
  end

  def create
    @injury_report = InjuryReport.new(params[:injury_report])
    if @injury_report.save
      flash[:notice] = 'InjuryReport was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @injury_report = InjuryReport.find(params[:id])
  end

  def update
    @injury_report = InjuryReport.find(params[:id])
    if @injury_report.update_attributes(params[:injury_report])
      flash[:notice] = 'InjuryReport was successfully updated.'
      redirect_to :action => 'show', :id => @injury_report
    else
      render :action => 'edit'
    end
  end

  def destroy
    InjuryReport.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
