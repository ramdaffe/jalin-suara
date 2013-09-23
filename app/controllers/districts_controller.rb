class DistrictsController < ApplicationController
  layout :resolve_layout
  helper_method :sort_column, :sort_direction

  add_breadcrumb "Beranda", :root_path

  # GET /districts
  # GET /districts.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count

    if params[:province_id] != nil
      @province = Province.find(params[:province_id])
      @districts = District.joins(:province).where(districts: {province_id: params[:province_id]}).search(params[:search]).order(sorting).paginate(:per_page => 20, :page => params[:page])

      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kabupaten", :districts_path
    else
      @districts = District.joins(:province).search(:province_name_or_name_contains => params[:search]).order(sorting).paginate(:per_page => 20, :page => params[:page])
      add_breadcrumb "Data Kabupaten", :districts_path
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @districts }
    end
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
    @district = District.find(params[:id])
    @subdistrict_stats = Subdistrict.find(:all, :conditions => ['district_id = ?', @district])    
    @activities = Activity.joins(:subdistrict).order('subdistricts.name, activities.name').paginate(:per_page => 10, :page => params[:page], :conditions => ['subdistrict_id IN (?)', @subdistrict_stats])

    if params[:province_id] != nil
      @province = Province.find(params[:province_id])
      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kabupaten", {:controller => "districts", :province_id => @province.id}
      add_breadcrumb "#{@district.name}", district_path(@district.id)
    else
      add_breadcrumb "Data Kabupaten", :districts_path
      add_breadcrumb "#{@district.name}", district_path(@district.id)
    end

    respond_to do |format|
      format.html
      format.json { render json: @district }
    end
  end

private
  def resolve_layout
    case action_name
    when 'show'
      'show_district'
    else
      'application'
    end
  end

  def sorting
    sort_order = ""
    if District.column_names.include?(params[:sort])
      sort_order = sort_column + ' ' + sort_direction
    elsif params[:sort] == "provinces.name"
      sort_order = sort_column + ' ' + sort_direction + ', ' + "districts.name ASC"
    else
      sort_order = "provinces.name, districts.name" 
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
