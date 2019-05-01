class SessionsController < ApplicationController
    def new
        render :new
        # debugger  #using this debugger, you can look at params and session_cookie (giant hash)
    end

    def create                      #Verify the user_name/password
        user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    
        if user
            login!(user)            #Reset the User's session_token
                                    #Update the session hash with the new session_token.
            redirect_to cats_url    #Redirect the user to the cats index page.
        else
            flash.now[:errors] = ["Invalid Name or Password"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end