require 'RMagick'
class Picture < ActiveRecord::Base

	has_one	:person

	def image
		decoded = Base64.decode64(self[:image])
	    if self[:id] >= 187
		  tmpimage = Magick::Image.from_blob(decoded)[0]
		  rotated = tmpimage.rotate(90)
		  final = rotated.to_blob
		  write_attribute('image', final)
	    else
		  write_attribute('image', decoded)
	    end
	end

	def image=(newimage)
		tmpimage = Magick::Image.from_blob(newimage)[0]
		scaled = tmpimage.scale(352, 288)
		saveimage = Base64.encode64(scaled.to_blob)
		self[:image] = saveimage
	end

	def thumbnail
		tmpimage = Magick::Image.from_blob(self.image)[0]
		scaled = tmpimage.scale(0.2)
		write_attribute('thumbnail', scaled.to_blob)
	end
end
