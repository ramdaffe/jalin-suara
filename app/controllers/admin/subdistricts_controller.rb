class Admin::SubdistrictsController < ApplicationController
  # GET /subdistricts
  # GET /subdistricts.json
  def index
    @subdistricts = Subdistrict.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render layout: 'admin' }
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
      format.html
      format.json { render json: @subdistrict }
    end
  end

  # GET /subdistricts/new
  # GET /subdistricts/new.json
  def new
    @subdistrict = Subdistrict.new

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: @subdistrict }
    end
  end

  # GET /subdistricts/1/edit
  def edit
    @subdistrict = Subdistrict.find(params[:id])

    respond_to do |format|
      format.html { render layout: 'admin' }
      format.json { render json: @subdistrict }
    end
  end

  # POST /subdistricts
  # POST /subdistricts.json
  def create
    @subdistrict = Subdistrict.new(params[:subdistrict])

    respond_to do |format|
      if @subdistrict.save
        format.html { redirect_to admin_subdistrict_path(@subdistrict), notice: 'Subdistrict was successfully created.' }
        format.json { render json: @subdistrict, status: :created, location: @subdistrict }
      else
        format.html { render action: "new" }
        format.json { render json: @subdistrict.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subdistricts/1
  # PUT /subdistricts/1.json
  def update
    @subdistrict = Subdistrict.find(params[:id])

    respond_to do |format|
      if @subdistrict.update_attributes(params[:subdistrict])
        format.html { redirect_to admin_subdistrict_path(@subdistrict), notice: 'Subdistrict was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subdistrict.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subdistricts/1
  # DELETE /subdistricts/1.json
  def destroy
    @subdistrict = Subdistrict.find(params[:id])
    @subdistrict.destroy

    respond_to do |format|
      format.html { redirect_to admin_subdistricts_url }
      format.json { head :no_content }
    end
  end
end