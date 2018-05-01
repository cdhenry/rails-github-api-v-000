class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://67.205.188.72:38790/auth"
      req.params['code'] = params[:code]
    end
    binding.pry
    start = body.index("=")
    finish = body.index("&")
    session[:token] = resp.body[start..finish]
    redirect_to root_path
  end
end
