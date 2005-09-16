class Picture < ActiveRecord::Base
	has_one	:person

	def image
		thispic = self.class.find(self.id)
		decoded = Base64.decode64(thispic[:image])
		write_attribute('image', decoded)
	end

	def image=(newimage)
		saveimage = Base64.encode64(newimage)
		self[:image] = saveimage
	end
end
