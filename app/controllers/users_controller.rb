class UsersController < ApplicationController

       get '/login' do

        erb :'/users/login'
       end

       post '/login' do
         @user = User.find_by(email: params[:email])
         if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id

            flash[:message] = "Welcome, #{@user.username}"
            redirect '/tweets'

         else
            flash[:errors] = "Invalid Credentials. Please Sign Up or Try Again!"
            redirect '/login'
         end

       end

       get '/signup' do
          erb :'/users/signup'
       end

       post '/signup' do
        
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
          session[:user_id] = @user_id
          flash[:message] = "You have sucessfully created an account, #{@user.username}!"
          redirect '/tweets'
        else
           flash[:error] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end
       end

       get '/logout' do
         session.clear
         redirect '/'
       end
end
