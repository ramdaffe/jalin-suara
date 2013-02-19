class HomeController < ApplicationController
  # GET /
  def index
    @activities = Activity.paginate(:page => params[:page])
    @json = Activity.paginate(:page => params[:page]).to_gmaps4rails

    # @graph = Koala::Facebook::API.new('AAACEdEose0cBAH5bVJbIksYTKircSrEEZCtN7aZBZAQJfjQvnWOxjwr413cf5wEjhDLmhbEiMs3UWjLQM8HFoUO03ZBHQZBjceRJ3DqkwrPcrfXP7mBCZA')
    # @facebook_feeds = @graph.get_connections("100005020144022", "feed")

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end
end
