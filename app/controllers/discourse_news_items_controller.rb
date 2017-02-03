class DiscourseNewsItemsController < ApplicationController
  before_action :set_discourse_news_item, only: [:show, :edit, :update, :destroy]

  # GET /discourse_news_items
  # GET /discourse_news_items.json
  def index
    @discourse_news_items = DiscourseNewsItem.all
  end

  # GET /discourse_news_items/1
  # GET /discourse_news_items/1.json
  def show
  end

  # GET /discourse_news_items/new
  def new
    @discourse_news_item = DiscourseNewsItem.new
  end

  # GET /discourse_news_items/1/edit
  def edit
  end

  # POST /discourse_news_items
  # POST /discourse_news_items.json
  def create
    @discourse_news_item = DiscourseNewsItem.new(discourse_news_item_params)

    respond_to do |format|
      if @discourse_news_item.save
        format.html { redirect_to @discourse_news_item, notice: 'Discourse news item was successfully created.' }
        format.json { render :show, status: :created, location: @discourse_news_item }
      else
        format.html { render :new }
        format.json { render json: @discourse_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discourse_news_items/1
  # PATCH/PUT /discourse_news_items/1.json
  def update
    respond_to do |format|
      if @discourse_news_item.update(discourse_news_item_params)
        format.html { redirect_to @discourse_news_item, notice: 'Discourse news item was successfully updated.' }
        format.json { render :show, status: :ok, location: @discourse_news_item }
      else
        format.html { render :edit }
        format.json { render json: @discourse_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discourse_news_items/1
  # DELETE /discourse_news_items/1.json
  def destroy
    @discourse_news_item.destroy
    respond_to do |format|
      format.html { redirect_to discourse_news_items_url, notice: 'Discourse news item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discourse_news_item
      @discourse_news_item = DiscourseNewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discourse_news_item_params
      params.fetch(:discourse_news_item, {})
    end
end
