class HomeController < ApplicationController
  layout 'three_columns'

  # GET /
  def index
    if params[:tab] == "recent"
      @listed_posts = Post.find(:all, :order => 'created_at DESC')
    else
      @listed_posts = Post.all.sort_by(&:comments_count).reverse
    end
    
    @posts = @listed_posts.find(:conditions => ["latitude IS NOT NULL and longitude IS NOT NULL"])
    @json = @posts.to_gmaps4rails

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end
end
