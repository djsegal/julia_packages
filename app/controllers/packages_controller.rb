class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  autocomplete :package, :name, \
    limit: Package.count, full: true, scopes: [:active_batch_scope]

  # GET /packages
  # GET /packages.json
  def index
    raw_params = params.with_indifferent_access

    @sort, @packages = PackageSorterJob.perform_now raw_params

    if @packages.length == 1
      redirect_to @packages.first
      return
    end
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    render 'layouts/error_page' \
      and return unless @package.present?

    @contributors = @package.contributions.order(score: :desc).limit(20).includes(:user).map(&:user)
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
      return unless Package.custom_exists? params[:id]
      @package = Package.custom_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name)
    end

end
