class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    render :text => request.env['omniauth.auth'].inspect
  end
  
  def twitter
    render :text => request.env['omniauth.auth'].inspect
  end
  
  def linkedin
    render :text => request.env['omniauth.auth'].inspect
  end
  
  def google_oauth2
    render :text => request.env['omniauth.auth'].inspect
  end  
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end
end