class HomeController < ApplicationController
  # GET /
  def index
  	@featured_activities_left = Activity.find(:all, :order => 'id DESC', :limit => 2)
    @featured_activities_right = Activity.find(:all, :order => 'id DESC', :offset => 2, :limit => 4)
    @activities = Activity.all
    @json = Activity.all.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end
end
