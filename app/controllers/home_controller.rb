class HomeController < ApplicationController
  # GET /
  def index
    if params[:tab] == "recent"
      @listed_posts = Post.find(:all, :order => 'created_at DESC')
    else
      @listed_posts = Post.all.sort_by(&:comments_count).reverse
    end
    
    # Filter to only show in Gmaps posts that have latitude and longitude 
    @posts = Post.find(:all, :conditions => ["latitude IS NOT NULL and longitude IS NOT NULL"])
    @json = @posts.to_gmaps4rails

    @provinces_number = Province.all.size
    @districts_number = District.all.size
    @subdistricts_number = Subdistrict.all.size
    @activities_number = Activity.all.size

    respond_to do |format|
      format.html { render layout: 'three_columns' }
      format.json { render json: @listed_posts }
    end
  end

  def search
    search_query = params[:query]
    @search = Sunspot.search(Subdistrict, Activity, Post) do 
      fulltext search_query 
    end
    @results = @search.results

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html { render layout: 'three_columns' }
      format.json { render json: @results }
    end
  end

  def show_map
    if params[:search] != nil
      @search = Activity.search(params[:search])
      activities = @search.all
    else
      activities = Activity.all
    end
    @json = activities.to_gmaps4rails

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
      format.html { render layout: 'three_columns' }
    end
  end
end
