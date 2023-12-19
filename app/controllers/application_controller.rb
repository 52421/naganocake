class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    case resource
     when Admin
      admin_path
     when Customer
      root_path
    end
  end
  
  def after_sign_up_path_for(resource)
    case resource
     when Admin
      admin_path
     when Customer
      root_path
    end
  end
  private
   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :postal_code, :address])
   end

end
