class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
    def login(user)
        session[:session_token] = user.reset_token!
    end
    def logged_in?
        !!current_user
        # current_user.session_token == session[:session_token]
    end
    def logout
        current_user.reset_token!
        session[:session_token] = nil
    end
    def current_user
        @user = User.find_by(session_token: session[:session_token])
    end
end
