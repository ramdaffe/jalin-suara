class Admin::HomeController < ApplicationController
  # GET /
  def index
    if params[:tab] == "comments"
      @entries = Comment.paginate(:page => params[:page], :order => 'created_at DESC')
    elsif params[:tab] == "users"
      @entries = User.paginate(:page => params[:page], :order => 'created_at DESC')  
    else
      @entries = Post.paginate(:page => params[:page], :order => 'created_at DESC')  
    end

    respond_to do |format|
      format.html { render layout: 'admin'}
      format.json { render json: @entries }
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
    @json = @activities.to_gmaps4rails

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html
      format.json { render json: @activities }
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
