class UsersController < ApplicationController
    
    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        # @user.cat_id = Cat.last.id ?????
        if @user.save
            login!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:user_name, :password)
    end

end