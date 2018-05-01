class SessionsController < ApplicationController
  def create
    resp = Faraday.get("https://github.com/oauth/access_token") do |req|
      req.params['client_id'] = ENV['GITHUB_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
    end

    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
