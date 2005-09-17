class EthnicitiesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @ethnicity_pages, @ethnicities = paginate :ethnicity, :per_page => 10
  end

  def show
    @ethnicity = Ethnicity.find(params[:id])
  end

  def new
    @ethnicity = Ethnicity.new
  end

  def create
    @ethnicity = Ethnicity.new(params[:ethnicity])
    if @ethnicity.save
      flash[:notice] = 'Ethnicity was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @ethnicity = Ethnicity.find(params[:id])
  end

  def update
    @ethnicity = Ethnicity.find(params[:id])
    if @ethnicity.update_attributes(params[:ethnicity])
      flash[:notice] = 'Ethnicity was successfully updated.'
      redirect_to :action => 'show', :id => @ethnicity
    else
      render :action => 'edit'
    end
  end

  def destroy
    Ethnicity.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
