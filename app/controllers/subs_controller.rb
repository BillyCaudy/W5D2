class SubsController < ApplicationController

    def require_moderator
        sub = Sub.find_by(id: params[:id])
        redirect_to subs_url unless sub && sub.moderator_id == current_user.id
    end

    before_action :require_moderator, only: [:edit, :update]
    def new
        @sub = Sub.new
    end
    def create
        @sub = Sub.new(sub_params)
        @sub.moderator_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end
    def edit
        @sub = Sub.find_by(id: params[:id])
    end
    def update
        @sub = Sub.find_by(id: params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :edit
        end
    end
    def index
        @subs = Sub.all
        
    end
    def show
        @sub = Sub.find_by(id: params[:id])
    end
    private
    def sub_params
        params.require(:sub).permit(:title,:description)
    end
end
