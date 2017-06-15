class StackOverflowNewsItemsController < ApplicationController
  before_action :set_stack_overflow_news_item, only: [:show, :edit, :update, :destroy]

  # GET /stack_overflow_news_items
  # GET /stack_overflow_news_items.json
  def index
    @stack_overflow_news_items = StackOverflowNewsItem.all
  end

  # GET /stack_overflow_news_items/1
  # GET /stack_overflow_news_items/1.json
  def show
  end

  # GET /stack_overflow_news_items/new
  def new
    @stack_overflow_news_item = StackOverflowNewsItem.new
  end

  # GET /stack_overflow_news_items/1/edit
  def edit
  end

  # POST /stack_overflow_news_items
  # POST /stack_overflow_news_items.json
  def create
    @stack_overflow_news_item = StackOverflowNewsItem.new(stack_overflow_news_item_params)

    respond_to do |format|
      if @stack_overflow_news_item.save
        format.html { redirect_to @stack_overflow_news_item, notice: 'Stack overflow news item was successfully created.' }
        format.json { render :show, status: :created, location: @stack_overflow_news_item }
      else
        format.html { render :new }
        format.json { render json: @stack_overflow_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stack_overflow_news_items/1
  # PATCH/PUT /stack_overflow_news_items/1.json
  def update
    respond_to do |format|
      if @stack_overflow_news_item.update(stack_overflow_news_item_params)
        format.html { redirect_to @stack_overflow_news_item, notice: 'Stack overflow news item was successfully updated.' }
        format.json { render :show, status: :ok, location: @stack_overflow_news_item }
      else
        format.html { render :edit }
        format.json { render json: @stack_overflow_news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stack_overflow_news_items/1
  # DELETE /stack_overflow_news_items/1.json
  def destroy
    @stack_overflow_news_item.destroy
    respond_to do |format|
      format.html { redirect_to stack_overflow_news_items_url, notice: 'Stack overflow news item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stack_overflow_news_item
      @stack_overflow_news_item = StackOverflowNewsItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stack_overflow_news_item_params
      params.fetch(:stack_overflow_news_item, {})
    end
end
