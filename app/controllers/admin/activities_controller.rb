class Admin::ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.joins(:subdistrict => {:district => :province}).order('provinces.name', 'subdistricts.name', 'activities.name').paginate(:page => params[:page], :order => 'name')

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])
    @postable = @activity
    @post = Post.new
    @posts = Post.find(:all, :conditions => {:postable_type => 'Activity', :postable_id => @activity.id}, :order => "created_at DESC")

    respond_to do |format|
      format.html { render layout: 'three_columns'}
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: @activity }
    end
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to admin_activity_path(@activity), notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to admin_activity_path(@activity), notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to admin_activities_url }
      format.json { head :no_content }
    end
  end

  def import_excel
    @excel_file = ExcelFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @excel_file }
    end
  end

  def empty_pnpm_data
    Province.destroy_all
    District.destroy_all
    Subdistrict.destroy_all
    ImplementerUnit.destroy_all
    Activity.destroy_all

    redirect_to admin_activities_url
  end
end
