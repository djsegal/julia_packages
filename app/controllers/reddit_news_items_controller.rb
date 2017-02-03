class RedditNewsItemsController < ApplicationController
  before_action :set_reddit_news_item, only: [:show, :edit, :update, :destroy]

  # GET /reddit_news_items
  # GET /reddit_news_items.json
  def index
    @reddit_news_items = RedditNewsItem.all
  end

  # GET /reddit_news_items/1
  # GET /reddit_news_items/1.json
  def show
  end

  # GET /reddit_news_items/new
  def new
    @reddit_news_item = RedditNewsItem.new
  end

  # GET /reddit_news_items/1/edit
  def edit
  end

  # POST /reddit_news_items
  # POST /reddit_news_items.json
  def create
    @reddit_news_item = RedditNewsItem.new(reddit_news_item_params)

    respond_to do |format|
      if @reddit_news_item.save
        format.html { redirect_to @reddit_news_item, notice: 'Reddit news item was successfully created.' }
        format.json { render :show, status: :created, location: @reddit_news_item }
      else
        format.html { render :new }
        format.json { render json: @reddit_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reddit_news_items/1
  # PATCH/PUT /reddit_news_items/1.json
  def update
    respond_to do |format|
      if @reddit_news_item.update(reddit_news_item_params)
        format.html { redirect_to @reddit_news_item, notice: 'Reddit news item was successfully updated.' }
        format.json { render :show, status: :ok, location: @reddit_news_item }
      else
        format.html { render :edit }
        format.json { render json: @reddit_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reddit_news_items/1
  # DELETE /reddit_news_items/1.json
  def destroy
    @reddit_news_item.destroy
    respond_to do |format|
      format.html { redirect_to reddit_news_items_url, notice: 'Reddit news item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reddit_news_item
      @reddit_news_item = RedditNewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reddit_news_item_params
      params.fetch(:reddit_news_item, {})
    end
end
