
# this model expects a certain database layout and its based on the name/login pattern. 
class User < ActiveRecord::Base

  # Please change the salt to something else, 
  # Every application should use a different one 

  # Authenticate a user. 
  #
  # Example:
  #   @user = User.authenticate('bob', 'bobpass')
  #
  def self.authenticate(login, pass)
    find_first(["login = ? AND password = ?", login, pass])
  end  
  

  protected

  # Apply SHA1 encryption to the supplied password. 
  # We will additionally surround the password with a salt 
  # for additional security. 
    
  
  # Before saving the record to database we will crypt the password 
  # using SHA1. 
  # We never store the actual password in the DB.
  
  # If the record is updated we will check if the password is empty.
  # If its empty we assume that the user didn't want to change his
  # password and just reset it to the old value.
  
  validates_uniqueness_of :login, :on => :create

  validates_confirmation_of :password
  validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_presence_of :login, :password, :password_confirmation
end
