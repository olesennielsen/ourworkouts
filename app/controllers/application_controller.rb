class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  rescue_from ActionView::MissingTemplate do |exception|
    # use exception.path to extract the path information
    # This does not work for partials
    redirect_to root_path, :alert => exception.message 
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, :alert => exception.message 
  end

end
