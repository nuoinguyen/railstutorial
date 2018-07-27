class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to users_path
    end
  end

  # GET /users/new
  def new
    puts @current_user
    if logged_in?
      flash[:success] = "You are logged in! "
      redirect_to user_path(@current_user.id)
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if logged_in?
      @user = User.find(params[:id])
    else
      redirect_to login_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    # respond_to do |format|
      if @user.save
        log_in @user
        flash[:success] = "Wellcome to the sample App! "
        redirect_to @user
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render :show, status: :created, location: @user }
      else
        # format.html { render :new }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
        render :new
      end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    # respond_to do |format|
    #   if @user.update(user_params)
      if @user.update_attributes(user_params)
        flash[:seccess] = "Profile updated"
        redirect_to @user
        # format.html { redirect_to @user, notice: 'User was successfully updated.' }
        # format.json { render :show, status: :ok, location: @user }
      else
        render 'edit'
        # format.html { render :edit }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    # end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Confirm a logged-in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please login"
        redirect_to login_path
      end
    end

    # Confirm the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user?(@user)
    end
end
