class SubdistrictsController < ApplicationController
  helper_method :sort_column, :sort_direction
  add_breadcrumb "Beranda", :root_path

  # GET /subdistricts
  # GET /subdistricts.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count

    if params[:province_id] != nil && params[:district_id] != nil
      @province = Province.find(params[:province_id])
      @district = District.find(params[:district_id])
      @subdistricts = Subdistrict.paginate(:page => params[:page], :order => 'name', :conditions => ['district_id = ?', params[:district_id]])

      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kabupaten", {:controller => "districts", :province_id => @province.id}
      add_breadcrumb "#{@district.name}", {:controller => "districts", :action => "show", :id => @district.id, :province_id => @province.id}
      add_breadcrumb "Data Kecamatan", :subdistricts_path
    elsif params[:province_id] != nil
      @province = Province.find(params[:province_id])
      @subdistricts = Subdistrict.paginate(:page => params[:page], :order => 'name', :conditions => ['district_id in (?)', @province.districts])

      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kecamatan", :subdistricts_path
    elsif params[:district_id] != nil
      @district = District.find(params[:district_id])
      @subdistricts = Subdistrict.paginate(:page => params[:page], :order => 'name', :conditions => ['district_id = ?', params[:district_id]])

      add_breadcrumb "Data Kabupaten", districts_path
      add_breadcrumb "#{@district.name}", district_path(@district.id)
      add_breadcrumb "Data Kecamatan", :subdistricts_path
    else
      @subdistricts = Subdistrict.joins(:district => :province).search(:district_province_name_or_name_contains => params[:search]).order(sorting).paginate(:per_page => 20, :page => params[:page])
      add_breadcrumb "Data Kecamatan", :subdistricts_path
    end

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @subdistricts }
    end
  end

  # GET /subdistricts/1
  # GET /subdistricts/1.json
  def show
    @subdistrict = Subdistrict.find(params[:id])
    @implementer_unit = @subdistrict.implementer_unit
    @activities = @subdistrict.activities
    @posts = Post.find(:all, :conditions => ["activity_id IN (?) OR (postable_type='Subdistrict' AND postable_id=?)", @activities, @subdistrict.id], :order => "created_at DESC")

    @postable = @subdistrict
    @post = Post.new

    if params[:province_id] != nil
      @province = Province.find(params[:province_id])
    end

    if params[:district_id] != nil
      @district = District.find(params[:district_id])
    end

    if @province != nil && @district != nil
      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kabupaten", {:controller => "districts", :province_id => @province.id}
      add_breadcrumb "#{@district.name}", {:controller => "districts", :action => "show", :id => @district.id, :province_id => @province.id}
      add_breadcrumb "Data Kecamatan", {:controller => "subdistricts", :province_id => @province.id}
      add_breadcrumb "#{@subdistrict.name}", subdistrict_path(@subdistrict.id)
    elsif @province != nil
      add_breadcrumb "Data Propinsi", :provinces_path
      add_breadcrumb "#{@province.name}", province_path(@province.id)
      add_breadcrumb "Data Kecamatan", {:controller => "subdistricts", :province_id => @province.id}
      add_breadcrumb "#{@subdistrict.name}", subdistrict_path(@subdistrict.id)
    elsif params[:district_id] != nil
      add_breadcrumb "Data Kabupaten", :districts_path
      add_breadcrumb "#{@district.name}", district_path(@district.id)
      add_breadcrumb "Data Kecamatan", {:controller => "subdistricts", :district_id => @district.id}
      add_breadcrumb "#{@subdistrict.name}", subdistrict_path(@subdistrict.id)
    else
      add_breadcrumb "Data Kecamatan", :subdistricts_path
      add_breadcrumb "#{@subdistrict.name}", subdistrict_path(@subdistrict.id)
    end

    respond_to do |format|
      format.html { render layout: 'three_columns'}
      format.json { render json: @subdistrict }
    end
  end

private

  def sorting
    sort_order = ""
    if Subdistrict.column_names.include?(params[:sort])
      sort_order = sort_column + ' ' + sort_direction
    elsif params[:sort] == "provinces.name"
      sort_order = sort_column + ' ' + sort_direction + ', ' + "subdistricts.name ASC"
    else
      sort_order = "provinces.name, subdistricts.name" 
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
