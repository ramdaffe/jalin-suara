class Admin::PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @post }
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if params["activity"] != "" 
      @post.postable_type = "Activity"
      @post.postable_id = params["activity"]
      activity = Activity.find(params["activity"])
      @post.latitude = activity.latitude
      @post.latitude = activity.longitude
    elsif params["subdistrict"] != ""
      @post.postable_type = "Subdistrict"
      @post.postable_id = params["subdistrict"]
      subdistrict = Subdistrict.find(params["subdistrict"])
      @post.latitude = subdistrict.latitude
      @post.longitude = subdistrict.longitude
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to admin_post_path(@post), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  def update_districts
    province = Province.find(params[:province])
    @districts = province.districts.map{|a| [a.name, a.id]}.insert(0, ["-Pilih kabupaten-", ""])

    respond_to do |format|
      format.js
    end
  end
 
  def update_subdistricts
    district = District.find(params[:district])
    @subdistricts = district.subdistricts.map{|s| [s.name, s.id]}.insert(0, ["-Pilih kecamatan-", ""])
  end

  def update_activities
    subdistrict = Subdistrict.find(params[:subdistrict])
    @activities = subdistrict.activities.map{|s| [s.name, s.id]}.insert(0, ["-Pilih sub proyek-", ""])
  end
end
