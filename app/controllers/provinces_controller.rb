class ProvincesController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /provinces
  # GET /provinces.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count

    # @provinces = Province.paginate(:page => params[:page], :order => (sort_column + ' ' + sort_direction))
    @provinces = Province.search(:name_contains => params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @provinces }
    end
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
    @province = Province.find(params[:id])
    @district_stats = District.find(:all, :conditions => {:province_id => @province.id})
    @subdistrict_stats = Subdistrict.find(:all, :conditions => ['district_id IN (?)', @province.districts], :order => 'name ASC')
    
    @activities = Activity.joins(:subdistrict).order('subdistricts.name, activities.name').paginate(:per_page => 10, :page => params[:page], :conditions => ['subdistrict_id IN (?)', @subdistrict_stats])
    @json = Activity.find(:all, :conditions => ['subdistrict_id IN (?)', @subdistrict_stats]).to_gmaps4rails

    respond_to do |format|
      format.html { render layout: 'three_columns'}
      format.json { render json: @province }
    end
  end

private

  def sort_column
    Province.column_names.include?(params[:sort]) ? params[:sort] : "name" 
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end