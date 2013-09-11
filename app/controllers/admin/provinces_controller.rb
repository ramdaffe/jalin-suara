class Admin::ProvincesController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /provinces
  # GET /provinces.json
  def index
    #@provinces = Province.paginate(:page => params[:page], :order => 'name')
    @provinces = Province.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => params[:page])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.js
      format.json { render json: @provinces }
    end
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
    @province = Province.find(params[:id])
    subdistricts = Subdistrict.find(:all, :conditions => ['district_id IN (?)', @province.districts])
    @activities = Activity.find(:all, :conditions => ['subdistrict_id IN (?)', subdistricts])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @province }
    end
  end

  # GET /provinces/new
  # GET /provinces/new.json
  def new
    @province = Province.new

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @province }
    end
  end

  # GET /provinces/1/edit
  def edit
    @province = Province.find(params[:id])

    respond_to do |format|
      format.html { render layout: "admin" }
      format.json { render json: @province }
    end
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.new(params[:province])

    respond_to do |format|
      if @province.save
        format.html { redirect_to admin_province_path(@province), notice: 'Province was successfully created.' }
        format.json { render json: @province, status: :created, location: @province }
      else
        format.html { render action: "new" }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /provinces/1
  # PUT /provinces/1.json
  def update
    @province = Province.find(params[:id])

    respond_to do |format|
      if @province.update_attributes(params[:province])
        format.html { redirect_to admin_province_path(@province), notice: 'Province was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @province.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /provinces/1
  # DELETE /provinces/1.json
  def destroy
    @province = Province.find(params[:id])
    @province.destroy

    respond_to do |format|
      format.html { redirect_to admin_provinces_url }
      format.json { head :no_content }
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