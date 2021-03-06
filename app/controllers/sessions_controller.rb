class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to_target_or_default root_url, :notice => t(:'helpers.messages.login')
    else
      flash.now[:alert] = t(:'helpers.messages.wrong_user')
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t(:'helpers.messages.logout')
  end
end
