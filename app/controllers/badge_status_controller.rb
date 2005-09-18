class BadgeStatusController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @badge_status_pages, @badge_status = paginate :badge_status, :per_page => 10
  end

  def show
    @badge_status = BadgeStatus.find(params[:id])
  end

  def new
    @badge_status = BadgeStatus.new
  end

  def create
    @badge_status = BadgeStatus.new(params[:badge_status])
    if @badge_status.save
      flash[:notice] = 'BadgeStatus was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @badge_status = BadgeStatus.find(params[:id])
  end

  def update
    @badge_status = BadgeStatus.find(params[:id])
    if @badge_status.update_attributes(params[:badge_status])
      flash[:notice] = 'BadgeStatus was successfully updated.'
      redirect_to :action => 'show', :id => @badge_status
    else
      render :action => 'edit'
    end
  end

  def destroy
    BadgeStatus.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
