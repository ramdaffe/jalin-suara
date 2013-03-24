class ProvincesController < ApplicationController
  # GET /provinces
  # GET /provinces.json
  def index
    @provinces_number = Province.all.size
    @districts_number = District.all.size
    @subdistricts_number = Subdistrict.all.size
    @activities_number = Activity.all.size

    @provinces = Province.paginate(:page => params[:page], :order => 'name')

    respond_to do |format|
      format.html
      format.json { render json: @provinces }
    end
  end

  # GET /provinces/1
  # GET /provinces/1.json
  def show
    @province = Province.find(params[:id])
    @district_stats = District.find(:all, :conditions => {:province_id => @province.id})
    @subdistrict_stats = Subdistrict.find(:all, :conditions => ['district_id IN (?)', @province.districts])
    
    @activities = Activity.paginate(:per_page => 20, :page => params[:page], :conditions => ['subdistrict_id IN (?)', @subdistrict_stats])
    @json = @activities.to_gmaps4rails

    respond_to do |format|
      format.html { render layout: 'three_columns'}
      format.json { render json: @province }
    end
  end

  # GET /provinces/new
  # GET /provinces/new.json
  def new
    @province = Province.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @province }
    end
  end

  # GET /provinces/1/edit
  def edit
    @province = Province.find(params[:id])
  end

  # POST /provinces
  # POST /provinces.json
  def create
    @province = Province.new(params[:province])

    respond_to do |format|
      if @province.save
        format.html { redirect_to @province, notice: 'Province was successfully created.' }
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
        format.html { redirect_to @province, notice: 'Province was successfully updated.' }
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
      format.html { redirect_to provinces_url }
      format.json { head :no_content }
    end
  end
end
