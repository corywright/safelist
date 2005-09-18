class PictureController < ApplicationController

	def upload_receive
		if @params[:file] && @params[:id]
			@person = Person.find(@params[:id])
			if @person.picture
				@person.picture.destroy
			end
			@picture = Picture.new
			@picture.image = @params[:file].read
			@picture.person_id = @person.id
			if @picture.save
			  @event = Event.new
			  @event.event_type = EventType.find($PICTURE_ADDED)
			  @event.person_id = @person.id
			  @event.event_time = Time.now
			  @event.shelter_id = session[:shelter_id]
			  @event.save
			  redirect_to :controller => 'people', :action => 'show', :id => @person.id
			end
	    else
			  flash[:error] = "Upload failed."
			  redirect_back_or_default :controller => 'people', :action => 'show', :id => @person.id
	    end
	end

	def show_image
		@picture = Picture.find_by_person_id(@params['id'])
		send_data @picture.image, :filename => @picture.id, :type => "image/jpeg", :disposition => "inline"
	end

	def preview
		@person = Person.find(params[:id])

	end

# everything below is for testing only
	def new
		@picture = Picture.new
	end

end
