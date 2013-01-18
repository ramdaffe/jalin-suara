class HomeController < ApplicationController
  # GET /
  def index
    @projects = Project.all
    @json = Project.all.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end
end
