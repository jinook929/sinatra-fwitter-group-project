class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'users/signup'
  end

  post '/signup' do
    if User.create(params).id
      session[:user_id] = User.last.id
      redirect "/tweets"
    end
    redirect "/signup"
  end

  get '/users/:slug' do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb :'users/show'
  end

  get '/login' do
    if logged_in?
      redirect "/tweets"
    end
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    end
    redirect "/signup"
  end

  get '/logout' do
    if not logged_in?
      redirect "/"
    end
    session.clear
    redirect "/login"
  end
end
