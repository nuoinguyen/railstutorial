class SessionsController < ApplicationController
    def new
        if logged_in?
            redirect_to user_path(@current_user.id)
        else
            render 'new'
        end
    end

    def create
        
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            if user.activated?
                log_in user
                params[:session][:remember_me] == '1' ? remember(user) : forget(user)
                
                redirect_back_or user
            else
                message = 'Account not activated.'
                message += "Check your email for activation link."
                flash[:warning] = message
                
                redirect_to root_path
            end

        else
            flash[:danger] = 'Invalid email/password combination' # Not quite right!
            render 'new'
        end

    end

    def destroy
        log_out if logged_in?
        redirect_to root_path
    end
end
