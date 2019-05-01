class ApplicationController < ActionController::Base 
    helper_method :current_user, :logged_in?
                            #Methods defined on ApplicationController still aren't available in your views
                            #so you need to make it a helper_method (to use this method elsewhere outside of this class)
    
    def current_user        #looks up the user with the current session token
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def login!(user)
        session[:session_token] = user.reset_session_token!
        @current_user = user
    end

    def logged_in?
        !!current_user
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
    end
end
