class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  autocomplete :package, :name, limit: Package.count, full: true

  # GET /packages
  # GET /packages.json
  def index
    @sort = params[:sort] || 'top'
    set_core_query

    case @sort
    when 'top'
      set_top_packages
    when 'new'
      set_new_packages
    when 'a_z'
      set_a_z_packages
    when 'z_a'
      set_z_a_packages
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
      @packages = @core_query.order("counters.stargazer desc")
    end

    def set_new_packages
      @packages = @core_query.order("daters.created desc")
    end

    def set_a_z_packages
      @packages = @core_query.order("LOWER(name) asc")
    end

    def set_z_a_packages
      @packages = @core_query.order("LOWER(name) desc")
    end

    def set_pop_packages
      live_packages = @core_query.where("daters.created > ?", 4.months.ago)
      dead_packages = @core_query.where.not("daters.created > ?", 4.months.ago)

      @packages = live_packages.or(dead_packages).order("daters.touched desc")
    end

    def set_core_query
      @core_query = Package
        .page(params[:page])
        .includes(:counter)
        .includes(:dater)

      return unless params[:search].present?
      @core_query = @core_query.where \
        "name like ?", "%#{params[:search]}%"
    end

end
