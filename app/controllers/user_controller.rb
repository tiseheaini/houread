class UserController < ApplicationController
  def sign_up
  end

	def sign_up_action
	  @user = User.authentication(params[:login], params[:password])
		if @user
		  session[:user_id] = @user.id
			redirect_to topics_path
	  else
		  render(:action => :sign_up)
	  end
	end
end
