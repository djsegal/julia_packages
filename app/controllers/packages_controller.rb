class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    if params[:depender].present?
      package_scope = Package.friendly.find(params[:depender]).depending
    elsif params[:dependee].present?
      package_scope = Package.friendly.find(params[:dependee]).dependents
    elsif params[:user].present?
      package_scope = Package.where(owner: params[:user])
    else
      package_scope = Package
    end

    set_packages package_scope

    is_single_search = !request.format.json?
    is_single_search &&= @packages.length == 1
    is_single_search &&= ( params[:search] || params[:s] ).present?

    redirect_to @packages.first if is_single_search
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.includes(:categories).friendly.find(params[:id].downcase.gsub(".jl", ""))
    end

    # Only allow a list of trusted parameters through.
    def package_params
      params.require(:package).permit(:name, :description, :readme, :stars)
    end
end
