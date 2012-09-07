class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    # the omniauth hash is defined in the callback from facebook
    omniauth = request.env["omniauth.auth"]
    # finds if there is an authentication from earlier, with the same provider and uid
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication # if the authentication exists the user is signed in
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user # if this authentication is the current_user then this authentication is added to authentications, not used at the moment but possible to add other providers
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else # if it does not exist the user is created by calling the apply_omniauth method
      group_name = params[:state]      
      group = Group.create!(:name => group_name)      
      user = User.new
      user.apply_facebook_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        user.groups << group
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  def twitter
    # the omniauth hash is defined in the callback from facebook
     omniauth = request.env["omniauth.auth"]
     # finds if there is an authentication from earlier, with the same provider and uid
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication # if the authentication exists the user is signed in
       flash[:notice] = "Signed in successfully."
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user # if this authentication is the current_user then this authentication is added to authentications, not used at the moment but possible to add other providers
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else # if it does not exist the user is created by calling the apply_omniauth method
       group_name = params[:state]           
       user = User.new
       user.apply_twitter_omniauth(omniauth)
       if user.save
         flash[:notice] = "Signed in successfully."
         group = Group.create!(:name => group_name)
         user.groups << group
         sign_in_and_redirect(:user, user)
       else
         session[:omniauth] = omniauth.except('extra')
         redirect_to new_user_registration_url
       end
     end
  end
  
  def linkedin
    # the omniauth hash is defined in the callback from facebook
     omniauth = request.env["omniauth.auth"]
     # finds if there is an authentication from earlier, with the same provider and uid
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication # if the authentication exists the user is signed in
       flash[:notice] = "Signed in successfully."
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user # if this authentication is the current_user then this authentication is added to authentications, not used at the moment but possible to add other providers
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else # if it does not exist the user is created by calling the apply_omniauth method
       group_name = params[:state]           
       user = User.new
       user.apply_linkedin_omniauth(omniauth)
       if user.save
         flash[:notice] = "Signed in successfully."
         group = Group.create!(:name => group_name)
         user.groups << group
         sign_in_and_redirect(:user, user)
       else
         session[:omniauth] = omniauth.except('extra')
         redirect_to new_user_registration_url
       end
     end
  end
  
  def google_oauth2
    # the omniauth hash is defined in the callback from facebook
     omniauth = request.env["omniauth.auth"]
     # finds if there is an authentication from earlier, with the same provider and uid
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication # if the authentication exists the user is signed in
       flash[:notice] = "Signed in successfully."
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user # if this authentication is the current_user then this authentication is added to authentications, not used at the moment but possible to add other providers
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else # if it does not exist the user is created by calling the apply_omniauth method
       group_name = params[:state]           
       user = User.new
       user.apply_google_omniauth(omniauth)
       if user.save
         flash[:notice] = "Signed in successfully."
         group = Group.create!(:name => group_name)
         user.groups << group
         sign_in_and_redirect(:user, user)
       else
         session[:omniauth] = omniauth.except('extra')
         redirect_to new_user_registration_url
       end
     end
  end
  
  def email
    @user = User.new
    @user.groups.build
  end
  
  def passthru    
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end
end