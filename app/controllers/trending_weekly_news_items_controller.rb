class TrendingWeeklyNewsItemsController < ApplicationController
  before_action :set_trending_weekly_news_item, only: [:show, :edit, :update, :destroy]

  # GET /trending_weekly_news_items
  # GET /trending_weekly_news_items.json
  def index
    @trending_weekly_news_items = TrendingWeeklyNewsItem.all
  end

  # GET /trending_weekly_news_items/1
  # GET /trending_weekly_news_items/1.json
  def show
  end

  # GET /trending_weekly_news_items/new
  def new
    @trending_weekly_news_item = TrendingWeeklyNewsItem.new
  end

  # GET /trending_weekly_news_items/1/edit
  def edit
  end

  # POST /trending_weekly_news_items
  # POST /trending_weekly_news_items.json
  def create
    @trending_weekly_news_item = TrendingWeeklyNewsItem.new(trending_weekly_news_item_params)

    respond_to do |format|
      if @trending_weekly_news_item.save
        format.html { redirect_to @trending_weekly_news_item, notice: 'Trending weekly news item was successfully created.' }
        format.json { render :show, status: :created, location: @trending_weekly_news_item }
      else
        format.html { render :new }
        format.json { render json: @trending_weekly_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trending_weekly_news_items/1
  # PATCH/PUT /trending_weekly_news_items/1.json
  def update
    respond_to do |format|
      if @trending_weekly_news_item.update(trending_weekly_news_item_params)
        format.html { redirect_to @trending_weekly_news_item, notice: 'Trending weekly news item was successfully updated.' }
        format.json { render :show, status: :ok, location: @trending_weekly_news_item }
      else
        format.html { render :edit }
        format.json { render json: @trending_weekly_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trending_weekly_news_items/1
  # DELETE /trending_weekly_news_items/1.json
  def destroy
    @trending_weekly_news_item.destroy
    respond_to do |format|
      format.html { redirect_to trending_weekly_news_items_url, notice: 'Trending weekly news item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trending_weekly_news_item
      @trending_weekly_news_item = TrendingWeeklyNewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trending_weekly_news_item_params
      params.fetch(:trending_weekly_news_item, {})
    end
end
