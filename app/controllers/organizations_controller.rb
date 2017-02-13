class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization
      .active_batch_scope
      .joins(owned_packages: :counter)
      .merge(Package.exclude_unregistered_packages(cookies))
      .references(:owned_packages)
      .group("organizations.id")
      .order("count(organizations.id) DESC")
      .order("sum(counters.stargazer) desc")
      .limit(100)
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    render 'layouts/error_page' \
      and return unless @organization.present?

    @owned_packages = @organization.owned_packages
      .includes(:counter).order("counters.stargazer desc")

    raw_params = params.with_indifferent_access
    raw_params[:organization_id] = raw_params.delete :id

    @sort, @packages = \
      PackageSorterJob.perform_now raw_params, cookies
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.custom_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :avatar)
    end
end
