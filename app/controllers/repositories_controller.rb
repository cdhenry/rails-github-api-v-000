class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
    end
    binding.pry
    @repos = JSON.parse(resp.body)
  end

  def create

  end
end
