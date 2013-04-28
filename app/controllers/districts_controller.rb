class DistrictsController < ApplicationController
  # GET /districts
  # GET /districts.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count

    if params[:province_id] != nil
      @province = Province.find(params[:province_id])
      @districts = District.paginate(:page => params[:page], :order => 'name', :conditions => ['province_id = ?', params[:province_id]])  
    else
      @districts = District.paginate(:page => params[:page], :order => 'name')
    end

    respond_to do |format|
      format.html
      format.json { render json: @districts }
    end
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
    @district = District.find(params[:id])
    @subdistrict_stats = Subdistrict.find(:all, :conditions => ['district_id = ?', @district])
    
    @activities = Activity.joins(:subdistrict).order('subdistricts.name, activities.name').paginate(:per_page => 10, :page => params[:page], :conditions => ['subdistrict_id IN (?)', @subdistrict_stats])
    @json = Activity.find(:all, :conditions => ['subdistrict_id IN (?)', @subdistrict_stats]).to_gmaps4rails

    respond_to do |format|
      format.html { render layout: 'three_columns'}
      format.json { render json: @district }
    end
  end
end
