class TweetsController < ApplicationController

     get '/tweets' do
         @tweets = Tweet.all
          erb :'/tweets/index'

     end

     get '/tweets/new' do 
         redirect_if_not_logged_in
           erb :'/tweets/new'    
     end

     post '/tweets' do
        redirect_if_not_logged_in
           if params[:content] != ""
              @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
              flash[:message] = "Tweet successully created." if @tweet.id
              redirect "/tweets/#{@tweet.id}"
           else
              flash[:errors] = "Something went wrong - content should be provided."
              redirect '/tweets/new'
           end
     end

     get '/tweets/:id' do
        @tweet = Tweet.find_by(id: params[:id])
        erb :'/tweets/show'
     end

     get '/tweets/:id/edit' do 
        redirect_if_not_logged_in
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user == current_user 
           erb :'/tweets/edit'
        else
           redirect '/tweets'
        end
        
     end

     patch '/tweets/:id' do 
       redirect_if_not_logged_in
       @tweet = Tweet.find_by(id: params[:id])
       if @tweet.user == current_user && params[:content] != ""
         @tweet.update(content: params[:content])
         redirect "/tweets/#{@tweet.id}"
       else
         redirect '/tweets'
       end
     end

     delete '/tweets/:id' do 
        @tweet = Tweet.find_by(id: params[:id])
        if @tweet.user == current_user
           @tweet.destroy
           flash[:message] = "Successfully deleted that Tweet."
           redirect '/tweets'
         else
            redirect '/tweets'
         end
     end
end
