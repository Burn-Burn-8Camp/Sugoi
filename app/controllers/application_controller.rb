class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


    helper_method :current_cart


    private
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
    end

    def current_cart
      @cart1289 ||= Cart.from_hash(session[:cart1289])
    end

end
