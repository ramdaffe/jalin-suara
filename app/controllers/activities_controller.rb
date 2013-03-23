class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @province_stats = Province.all
    @district_stats = District.all
    @subdistrict_stats = Subdistrict.all
    @activities_stats = Activity.all
    
    if params[:province_id] != nil
      districts = District.find(:all, :conditions => ['province_id = ?', params[:province_id]])
      subdistricts = Subdistrict.find(:all, :conditions => ['district_id in (?)', districts])
      @activities = Activity.paginate(:page => params[:page], :order => 'name', :conditions => ['subdistrict_id in (?)', subdistricts])
    elsif params[:district_id] != nil
      subdistricts = Subdistrict.find(:all, :conditions => ['district_id = ?', params[:district_id]])
      @activities = Activity.paginate(:page => params[:page], :order => 'name', :conditions => ['subdistrict_id in (?)', subdistricts])
    else
      @activities = Activity.paginate(:page => params[:page], :order => 'name')
    end

    respond_to do |format|
      format.html
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
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
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
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
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
      format.html { redirect_to activities_url }
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
end
