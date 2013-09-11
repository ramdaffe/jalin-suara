class ActivitiesController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /activities
  # GET /activities.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count
    
    if params[:province_id] != nil
      districts = District.find(:all, :conditions => ['province_id = ?', params[:province_id]])
      subdistricts = Subdistrict.find(:all, :conditions => ['district_id in (?)', districts])
      @activities = Activity.paginate(:page => params[:page], :order => 'name', :conditions => ['subdistrict_id in (?)', subdistricts])
    elsif params[:district_id] != nil
      subdistricts = Subdistrict.find(:all, :conditions => ['district_id = ?', params[:district_id]])
      @activities = Activity.paginate(:page => params[:page], :order => 'name', :conditions => ['subdistrict_id in (?)', subdistricts])
    else
      @activities = Activity.joins(:subdistrict => {:district => :province}).search(:name_or_subdistrict_name_or_subdistrict_district_province_name_contains => params[:search]).order(sorting).paginate(:per_page => 20, :page => params[:page])
      #@activities = Activity.joins(:subdistrict => {:district => :province}).order('provinces.name', 'subdistricts.name', 'activities.name').paginate(:page => params[:page], :order => 'name')
    end

    respond_to do |format|
      format.html
      format.js
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
    @implementer_unit = @activity.subdistrict.implementer_unit

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

private

  def sorting
    sort_order = ""
    if Activity.column_names.include?(params[:sort])
      sort_order =  sort_column + " " + sort_direction + ", provinces.name ASC, subdistricts.name ASC"  
    elsif params[:sort] == "provinces.name"
      sort_order = sort_column + " " + sort_direction + ", " + "subdistricts.name ASC, activities.name ASC"
    elsif params[:sort] == "subdistricts.name"
      sort_order = sort_column + " " + sort_direction + ", provinces.name ASC, activities.name ASC"
    else
      sort_order = "provinces.name, subdistricts.name, activities.name"
    end
    return sort_order
  end

  def sort_column
    (params[:sort])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
