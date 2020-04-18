class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]

  # GET /suggestions
  # GET /suggestions.json
  def index
    cur_association = params[:sort] || "package"
    cur_order_param = params[:order] || "asc"

    cur_includes = cur_association.to_sym
    cur_order = "#{cur_association.gsub("sub_", "").pluralize}.name #{cur_order_param}"

    suggestion_scope = Suggestion.includes(cur_includes).order(cur_order)
    @pagy, @suggestions = pagy(suggestion_scope)
  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    cur_params = suggestion_params
    cur_params.delete_if { |k, v| !v.present? }

    @package = Package.friendly.find(cur_params[:package_id])
    cur_params[:package_id] = @package

    suggestion_dict = {
      package: @package,
      category: nil, sub_category: nil
    }

    suggestion_dict[:category] = Category.friendly.find(cur_params[:category_id]) \
      if cur_params.has_key?(:category_id)

    suggestion_dict[:sub_category] = Category.friendly.find(cur_params[:sub_category_id]) \
      if cur_params.has_key?(:sub_category_id)

    @suggestion = Suggestion.new(suggestion_dict)

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @package, notice: '[success] Suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        if suggestion_dict[:category].present?
          format.html { redirect_to @package, notice: '[info] Suggestion has already been made.' }
        else
          format.html { redirect_to @package, notice: '[warning] You need to select a category.' }
        end

        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suggestion_params
      params.require(:suggestion).permit(:category_id, :sub_category_id, :package_id)
    end
end