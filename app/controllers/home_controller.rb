class HomeController < ApplicationController
  # GET /
  def index
    @recent_posts = Post.find(:all, :order => 'created_at DESC', :limit => 5)
    @popular_posts = Post.all.sort_by(&:comments_count).reverse.first(5)
    
    # Filter to only show in Gmaps posts that have latitude and longitude 
    @posts = Post.find(:all, :conditions => ["latitude IS NOT NULL and longitude IS NOT NULL"])
    @json = @posts.to_gmaps4rails

    @provinces_number = Province.all.size
    @districts_number = District.all.size
    @subdistricts_number = Subdistrict.all.size
    @activities_number = Activity.all.size

    respond_to do |format|
      format.html
      format.json { render json: @listed_posts }
    end
  end

  def search
    search_query = params[:query]
    @search = Sunspot.search(Province, District, Subdistrict, Activity, Post) do 
      fulltext search_query
      paginate(:page => params[:page], :per_page => params[:per_page])
    end
    @results = @search.results

    @provinces_number = Province.all.size
    @districts_number = District.all.size
    @subdistricts_number = Subdistrict.all.size
    @activities_number = Activity.all.size

    respond_to do |format|
      format.html
      format.json { render json: @results }
    end
  end

  def show_map
    if params[:search] != nil
      @search = Subdistrict.search(params[:search])
      subdistricts = @search.all
    else
      subdistricts = Subdistrict.find(:all)
    end
    @json = subdistricts.to_gmaps4rails

    respond_to do |format|
      format.html
    end
  end

  def about
    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all
    @activities = Activity.all
    
    respond_to do |format|
      format.html
    end
  end
end
