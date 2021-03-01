class TweetsController < ApplicationController

  get '/tweets' do
    if not logged_in?
      redirect "/login"
    end
    @tweets = Tweet.all
    erb :'tweets/index'
  end

  get '/tweets/new' do
    if not logged_in?
      redirect "/login"
    end
    erb :'tweets/new'
  end

  post '/tweets' do
    current_user.tweets.create(params)
    if @tweet = Tweet.all.last
      erb :'tweets/show'
    end
    redirect "/tweets/new"    
  end

  get '/tweets/:id' do
    if not logged_in?
      redirect "/login"
    end
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    if not logged_in?
      redirect "/login"
    end
    @tweet = Tweet.find_by(id: params[:id])    
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    end
    params.delete("_method")
    Tweet.update(params[:id], params)
    redirect "/tweets/#{params[:id]}"
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by(id: params[:id])
    if current_user != tweet.user
      redirect "/tweets/#{params[:id]}"
    end
    tweet.destroy
    redirect "/tweets"
  end
end
