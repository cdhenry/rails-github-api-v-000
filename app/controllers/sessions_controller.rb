class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # resp = Faraday.get("https://github.com/login/oauth/access_token") do |req|
    #   req.params['client_id'] = ENV['GITHUB_ID']
    #   req.params['client_secret'] = ENV['GITHUB_SECRET']
    #   req.params['redirect_uri'] = "http://67.205.188.72:38790/auth"
    #   req.params['code'] = params[:code]
    # end
    # body = resp.body
    # start = body.index("=")
    # finish = body.index("&")
    # session[:token] = resp.body[start+1..finish-1]

    response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
    access_hash = JSON.parse(response.body)
    session[:token] = access_hash["access_token"]

    user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_response.body)
    session[:username] = user_json["login"]

    redirect_to root_path
  end
end
