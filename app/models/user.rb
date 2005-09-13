require 'digest/sha1' 

class User < ActiveRecord::Base 
  def passwd=(str) 
    write_attribute("passwd", Digest::SHA1.hexdigest(str)) 
  end 

  def passwd 
    "*****"  
  end 

  def self.authenticate(username, passwd) 
	if passwd.nil?
		passwd = ''
	end
    find(:first, :conditions => [ "username = ? AND passwd =?", 
               username, 
               Digest::SHA1.hexdigest(passwd) ]) 
  end 
end
