class HomeController < ApplicationController
  layout :resolve_layout

  # GET /
  def index
    @recent_posts = Post.find(:all, :order => 'created_at DESC', :limit => 5)
    @popular_posts = Post.all.sort_by(&:comments_count).reverse.first(20)
    
    # Filter to only show in Gmaps posts that have latitude and longitude 
    @posts = Post.find(:all, :conditions => ["latitude IS NOT NULL and longitude IS NOT NULL"])

    # @provinces_number = Province.all.size
    # @districts_number = District.all.size
    # @activities_number = Activity.all.size
    # @activities_number = Activity.all.size

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def search
    search_query = params[:query]
    @search = Sunspot.search(Province, District, Activity, Activity, Post) do 
      fulltext search_query
      paginate(:page => params[:page], :per_page => params[:per_page])
    end
    @results = @search.results

    @provinces_number = Province.all.size
    @districts_number = District.all.size
    @activities_number = Activity.all.size
    @activities_number = Activity.all.size

    respond_to do |format|
      format.html
      format.json { render json: @results }
    end
  end

  def show_map
    if params[:search] != nil
      @search = Activity.search(params[:search])
      @activities = @search.all
    else
      @activities = Activity.all
    end
    # @json = activities.to_gmaps4rails

    respond_to do |format|
      format.html
      format.json { render json: @activities }
    end
  end

  def about
    @provinces = Province.all
    @districts = District.all
    @activities = Activity.all
    @activities = Activity.all
    
    respond_to do |format|
      format.html
    end
  end

private
  def resolve_layout
    case action_name
    when 'show_map'
      'show_map'
    when 'index'
      'home_index'
    else
      'application'
    end
  end
end
