class SessionsController < ApplicationController
  def create
    data = request.env['omniauth.auth']
    session[:user] = {
      screen_name: data['info']['nickname'],
      user_id: data['uid'],
      api_access_key: ENV['TWITTER_KEY'],
      api_secret_key: ENV['TWITTER_SECRET'],
      user_token: data['credentials']['token'],
      user_secret: data['credentials']['secret']
    }
    redirect_to root_path, notice: 'ログインしました'
  end

  def destroy
    session[:user] = nil
    redirect_to root_path, notice: 'ログアウトしました'
  end

  def oauth_failure
    redirect_to root_path, notice: 'ログインに失敗しました'
  end
end
