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

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all
    @activities = Activity.all

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
    # @activities = Activity.all
    if params[:search] != nil
      province_name = params[:search][:province_name]
      district_name = params[:search][:district_name]
      subdistrict_name = params[:search][:subdistrict_name]
      activity_name = params[:search][:activity_name]

      # @activities = Activity.find_by_filter(province_name, district_name, subdistrict_name, activity_name)
      @activities = Activity.find(:all, :conditions => ["subdistrict_id in (?)", District.find(100).subdistricts])
    else
      @activities = Activity.find(:all, :conditions => ["subdistrict_id in (?)", District.find(100).subdistricts])
    end
    @json = @activities.to_gmaps4rails

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end
end
