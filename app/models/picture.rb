class Picture < ActiveRecord::Base
	has_one	:person

	def image
		decoded = Base64.decode64(self[:image])
		write_attribute('image', decoded)
	end

	def image=(newimage)
		saveimage = Base64.encode64(newimage)
		self[:image] = saveimage
	end
end
