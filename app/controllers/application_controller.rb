class ApplicationController < ActionController::Base
    include Pagy::Backend
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    helper_method :current_cart, :current_store
    helper_method :user_signed_in?, :current_user


    
    private
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end

    def current_cart
      @cart1289 ||= Cart.from_hash(session[:cart1289])
    end

    def record_not_found
      render file: 'public/404.html', stats: :not_found
    end

    def current_store
      current_user.store
    end
end

