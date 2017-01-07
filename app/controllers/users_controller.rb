class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    has_package = params[:package_id].present?
    has_package &&= Package.custom_exists? params[:package_id]

    if has_package
      @package = Package.custom_find params[:package_id]
      @users = @package.contributions.order(score: :desc).includes(:user).map(&:user)
    else
      @users = User
        .joins(:supported_packages).includes(:contributions)
        .group("users.id")
        .order("sum(contributions.score) desc")
        .limit(150)
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @owned_packages = @user.owned_packages
      .includes(:counter).order("counters.stargazer desc")

    max_supported_packages = 20

    @supported_packages = @user.supported_packages
      .includes(:contributions).order("contributions.score desc")
      .limit(max_supported_packages)

    @has_many_supported = \
      ( @user.supported_packages.count > max_supported_packages )
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
      @user = User.custom_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name)
    end
end
