class AuthController < ApplicationController
  layout  'auth'

  def login
    case @request.method
      when :post
      if @session[:user] = User.authenticate(@params[:user_login], @params[:user_password])
	    @session[:shelter_id] = @session[:user].shelter_id
        flash['notice']  = "Login successful"
        redirect_back_or_default :controller => 'hello'
      else
        flash.now['notice']  = "Login unsuccessful"

        @login = @params[:user_login]
      end
    end
  end
  
  def show_info
  end

  
#  def signup
#    @user = User.new(@params[:user])
#
#    if @request.post? and @user.save
#      @session[:user] = User.authenticate(@user.login, @params[:user][:password])
#      flash['notice']  = "Signup successful"
#      redirect_back_or_default :action => "welcome"
#    end      
#  end  
  
  def logout
    @session[:user] = nil
  end
    
  def welcome
  end
  
end
