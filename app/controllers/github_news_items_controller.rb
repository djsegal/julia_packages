class GithubNewsItemsController < ApplicationController
  before_action :set_github_news_item, only: [:show, :edit, :update, :destroy]

  # GET /github_news_items
  # GET /github_news_items.json
  def index
    @github_news_items = GithubNewsItem.all
  end

  # GET /github_news_items/1
  # GET /github_news_items/1.json
  def show
  end

  # GET /github_news_items/new
  def new
    @github_news_item = GithubNewsItem.new
  end

  # GET /github_news_items/1/edit
  def edit
  end

  # POST /github_news_items
  # POST /github_news_items.json
  def create
    @github_news_item = GithubNewsItem.new(github_news_item_params)

    respond_to do |format|
      if @github_news_item.save
        format.html { redirect_to @github_news_item, notice: 'Github news item was successfully created.' }
        format.json { render :show, status: :created, location: @github_news_item }
      else
        format.html { render :new }
        format.json { render json: @github_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /github_news_items/1
  # PATCH/PUT /github_news_items/1.json
  def update
    respond_to do |format|
      if @github_news_item.update(github_news_item_params)
        format.html { redirect_to @github_news_item, notice: 'Github news item was successfully updated.' }
        format.json { render :show, status: :ok, location: @github_news_item }
      else
        format.html { render :edit }
        format.json { render json: @github_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /github_news_items/1
  # DELETE /github_news_items/1.json
  def destroy
    @github_news_item.destroy
    respond_to do |format|
      format.html { redirect_to github_news_items_url, notice: 'Github news item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_github_news_item
      @github_news_item = GithubNewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def github_news_item_params
      params.fetch(:github_news_item, {})
    end
end
