class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pagy::Backend
    helper_method :current_cart

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found




    
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

end

