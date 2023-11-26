class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :restrict_guest_user

  protected
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  
  def after_update_path_for(resource)
    user_path(resource)
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image])
  end
  
  def guest_user?
    current_user && current_user.email == 'guest@example.com'
  end
  
  private
  
  def restrict_guest_user
     if current_user&.guest? && (request.path != posts_path) && (request.path != destroy_user_session_path)
      sign_out current_user
      redirect_to new_user_registration_path
    end
  end
  
end
