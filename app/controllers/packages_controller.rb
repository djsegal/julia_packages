class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  autocomplete :package, :name, limit: Package.count, full: true

  # GET /packages
  # GET /packages.json
  def index
    @sort = params[:sort] || 'top'

    case @sort
    when 'top'
      set_top_packages
    when 'new'
      set_new_packages
    when 'pop'
      set_pop_packages
    else
      raise "Invalid sorting method."
    end

    @categories = Category.all
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
      @package = Package.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name)
    end

    def set_top_packages
      @packages = Package
        .includes(:counter)
        .order("counters.stargazer desc")
        .paginate(page: params[:page])

      @packages = @packages.where("name like ?", "%#{params[:search]}%") \
        if params[:search].present?
    end

    def set_new_packages
      @packages = Package
        .includes(:dater)
        .order("daters.created desc")
        .paginate(page: params[:page])

      @packages = @packages.where("name like ?", "%#{params[:search]}%") \
        if params[:search].present?
    end

    def set_pop_packages
      core_query = Package.includes(:dater)

      core_query = core_query.where("name like ?", "%#{params[:search]}%") \
        if params[:search].present?

      live_packages = core_query.where("daters.pushed > ?", 4.months.ago)
      dead_packages = core_query.where.not("daters.pushed > ?", 4.months.ago)

      @packages = live_packages.or(dead_packages).order("daters.pushed desc").paginate(page: params[:page])
    end

end
