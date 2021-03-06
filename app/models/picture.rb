require 'RMagick'
class Picture < ActiveRecord::Base

	belongs_to :person

	def image
		decoded = Base64.decode64(self[:image])
	    if self[:id] >= 187
		# remove this block after fix-pics-in-db
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
# uncomment these and comment the other saveimage after fix-pics-in-db has been run
#		rotated = tmpimage.rotate(90)
#		saveimage = Base64.encode64(rotated.to_blob)
		saveimage = Base64.encode64(scaled.to_blob)
		self[:image] = saveimage
	end

	def thumbnail
		tmpimage = Magick::Image.from_blob(self.image)[0]
		scaled = tmpimage.scale(0.2)
		write_attribute('thumbnail', scaled.to_blob)
	end

	def fix_rotation
	    decoded = Base64.decode64(self[:image])
        if self[:id] >= 187
          tmpimage = Magick::Image.from_blob(decoded)[0]
          rotated = tmpimage.rotate(90)
          final = Base64.encode64(rotated.to_blob)
		  self[:image] = final
        end
	end

end
