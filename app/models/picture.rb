require 'RMagick'
class Picture < ActiveRecord::Base

	has_one	:person

	def image
		decoded = Base64.decode64(self[:image])
		write_attribute('image', decoded)
	end

	def image=(newimage)
		tmpimage = Magick::Image.from_blob(newimage)[0]
		scaled = tmpimage.resize(352, 288)
		saveimage = Base64.encode64(scaled.to_blob)
#	    saveimage = Base64.encode64(newimage)
		self[:image] = saveimage
	end
end
