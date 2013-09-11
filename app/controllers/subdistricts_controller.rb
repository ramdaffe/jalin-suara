class SubdistrictsController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /subdistricts
  # GET /subdistricts.json
  def index
    @provinces_number = Province.count
    @districts_number = District.count
    @subdistricts_number = Subdistrict.count
    @activities_number = Activity.count

    if params[:province_id] != nil
      districts = District.find(:all, :conditions => ['province_id = ?', params[:province_id]])
      @subdistricts = Subdistrict.paginate(:page => params[:page], :order => 'name', :conditions => ['district_id in (?)', districts])
    elsif params[:district_id] != nil
      @district = District.find(params[:district_id])
      @subdistricts = Subdistrict.paginate(:page => params[:page], :order => 'name', :conditions => ['district_id = ?', params[:district_id]])
    else
      @subdistricts = Subdistrict.joins(:district => :province).search(params[:search]).order(sorting).paginate(:per_page => 20, :page => params[:page])
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
