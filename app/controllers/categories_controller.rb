class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    all_categories = Category.where.not(name: "Trending").order(labels_count: :desc).to_a

    category_names = $category_tree.keys
    category_list = all_categories.select { |cur_category| category_names.include? cur_category.name }

    sub_category_names = $category_tree.values.flatten
    @sub_categories = all_categories.select { |cur_category| sub_category_names.include? cur_category.name }

    @category_dict = {}

    category_list.each do |cur_category|
      cur_value = $category_tree[cur_category.name]

      cur_sub_categories = @sub_categories.select do |tmp_category|
        cur_value.include? tmp_category.name
      end

      if ( cur_sub_categories.length < 2 )
        @sub_categories.reject! { |sub_category| cur_sub_categories.include? sub_category }
        cur_sub_categories = []
      end

      @category_dict[cur_category] = cur_sub_categories
    end

    @sub_category_dict = {}

    @category_dict.each do |cur_key, cur_values|
      cur_values.each do |cur_value|
        @sub_category_dict[cur_value] = cur_key
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    set_packages @category.packages
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id].downcase)
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
