class HomeController < ApplicationController
  layout 'three_columns'
  # GET /
  def index
    @activities = Activity.paginate(:page => params[:page])
    @json = Activity.paginate(:page => params[:page]).to_gmaps4rails

    @provinces = Province.all
    @districts = District.all
    @subdistricts = Subdistrict.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end
end
