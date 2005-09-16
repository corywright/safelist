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
			  redirect_to :controller => 'people', :action => 'show', :id => @person.id
			else
			  flash[:error] = "Upload failed."
			  redirect_to :action => 'new'
			end
		else
			#error handling?
		end
	end

	def show_image
		@picture = Picture.find_by_person_id(@params['id'])
		send_data @picture.image, :filename => @picture.id, :type => "image/jpeg", :disposition => "inline"
	end

# everything below is for testing only
	def new
		@picture = Picture.new
	end

end
