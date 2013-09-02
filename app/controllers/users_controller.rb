class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    if params[:tab] == "comments"
      @entries = Comment.where(owner_id: @user.id).paginate(:page => params[:page], :order => 'created_at DESC')
    else
      @entries = Post.where(user_id: @user.id).paginate(:page => params[:page], :order => 'created_at DESC')
    end

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
