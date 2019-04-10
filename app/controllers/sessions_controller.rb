class SessionsController < ApplicationController
    def new
        @user = User.new
    end
    def create
        user = User.find_by(username: params[:user][:username])
        if user && user.valid_password?(params[:user][:password])
            login(user)
            redirect_to subs_url
        else
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end
    def destroy
        logout
        redirect_to new_session_url
    end
end
