class ImplementerUnitsController < ApplicationController
  # GET /implementer_units
  # GET /implementer_units.json
  def index
    @implementer_units = ImplementerUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @implementer_units }
    end
  end

  # GET /implementer_units/1
  # GET /implementer_units/1.json
  def show
    @implementer_unit = ImplementerUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @implementer_unit }
    end
  end

  # GET /implementer_units/new
  # GET /implementer_units/new.json
  def new
    @implementer_unit = ImplementerUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @implementer_unit }
    end
  end

  # GET /implementer_units/1/edit
  def edit
    @implementer_unit = ImplementerUnit.find(params[:id])
  end

  # POST /implementer_units
  # POST /implementer_units.json
  def create
    @implementer_unit = ImplementerUnit.new(params[:implementer_unit])

    respond_to do |format|
      if @implementer_unit.save
        format.html { redirect_to @implementer_unit, notice: 'Implementer unit was successfully created.' }
        format.json { render json: @implementer_unit, status: :created, location: @implementer_unit }
      else
        format.html { render action: "new" }
        format.json { render json: @implementer_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /implementer_units/1
  # PUT /implementer_units/1.json
  def update
    @implementer_unit = ImplementerUnit.find(params[:id])

    # TO DO
    # 1. Evaluate the else condition, should have returned user to the form page
    # 2. Evaluate is it needed to make this method consider update from other sources than Subdistrict show page
    respond_to do |format|
      if @implementer_unit.update_attributes(params[:implementer_unit])
        format.html { redirect_to subdistrict_path(@implementer_unit.subdistrict), notice: 'Post was successfully created.' }
      else
        format.html { redirect_to subdistrict_path(@implementer_unit.subdistrict), notice: 'Post was successfully created.' }
        format.json { render json: @implementer_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /implementer_units/1
  # DELETE /implementer_units/1.json
  def destroy
    @implementer_unit = ImplementerUnit.find(params[:id])
    @implementer_unit.destroy

    respond_to do |format|
      format.html { redirect_to implementer_units_url }
      format.json { head :no_content }
    end
  end
end
