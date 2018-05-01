class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['access_token'] = session[:token]
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      binding.pry
      req.params['access_token'] = session[:token],
      req.params['name'] = params[:name]
    end
    binding.pry
    @repos = JSON.parse(resp.body)
  end
end
