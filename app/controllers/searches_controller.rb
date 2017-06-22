class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def autocomplete
    custom_params = params.to_unsafe_h

    custom_params[:autocomplete] = true

    _, packages_search_1 = PackageSorterJob.perform_now custom_params, cookies

    packages_search_1 ||= []

    custom_params[:default_search] = true

    _, packages_search_2 = PackageSorterJob.perform_now custom_params, cookies

    packages = ( packages_search_1 + packages_search_2 ).uniq.sort

    package_json = packages.map { |package|
      {
        id: package.id,
        label: package.name,
        value: package.name
      }
    }

    render json: package_json.sort_by{ |p| p[:label] }
  end

  # GET /searches
  # GET /searches.json
  def index
    raw_params = params.with_indifferent_access

    @search_count = 100

    raw_params[:per_page] = @search_count

    raw_params[:sort] ||= "search"

    _, @packages = \
      PackageSorterJob.perform_now raw_params, cookies

    @packages ||= []

    is_first_page = ( not raw_params[:page].present? ) || raw_params[:page] == 1

    if is_first_page && @packages.length < @search_count
      @disable_paginate = true

      raw_params[:default_search] = true

      _, extra_packages = \
        PackageSorterJob.perform_now raw_params, cookies

      @packages += extra_packages
      @packages.uniq!
    end

    if @packages.length == 1
      redirect_to @packages.first
      return
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.fetch(:search, {})
    end
end
