class User < ActiveRecord::Base 
  def self.authenticate(username, passwd) 
    find(:first, :conditions => [ "username = ? AND passwd =?", 
               username, 
               passwd]) 
  end 
end
