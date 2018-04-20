class BotsController < ApplicationController
  before_action :set_bot, only: [:show, :edit, :update, :destroy]

  # GET /bots
  # GET /bots.json
  def index
    @page = ( params[:page] || 1 ).to_i
    @per_page = 100

    @bots = Bot
      .active_batch_scope
      .joins(owned_packages: :counter)
      .merge(Package.exclude_unregistered_packages(cookies))
      .references(:owned_packages)
      .group("bots.id")
      .order("count(bots.id) DESC")
      .order("sum(counters.stargazer) desc")
      .paginate(page: params[:page], per_page: @per_page)
  end

  # GET /bots/1
  # GET /bots/1.json
  def show
    render 'layouts/error_page', status: 404 \
      and return unless @bot.present?

    @owned_packages = @bot.owned_packages
      .includes(:counter).order("counters.stargazer desc")

    raw_params = params.with_indifferent_access
    raw_params[:bot_id] = raw_params.delete :id

    @sort, @packages = \
      PackageSorterJob.perform_now raw_params, cookies
  end

  # GET /bots/new
  def new
    @bot = Bot.new
  end

  # GET /bots/1/edit
  def edit
  end

  # POST /bots
  # POST /bots.json
  def create
    @bot = Bot.new(bot_params)

    respond_to do |format|
      if @bot.save
        format.html { redirect_to @bot, notice: 'Bot was successfully created.' }
        format.json { render :show, status: :created, location: @bot }
      else
        format.html { render :new }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bots/1
  # PATCH/PUT /bots/1.json
  def update
    respond_to do |format|
      if @bot.update(bot_params)
        format.html { redirect_to @bot, notice: 'Bot was successfully updated.' }
        format.json { render :show, status: :ok, location: @bot }
      else
        format.html { render :edit }
        format.json { render json: @bot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bots/1
  # DELETE /bots/1.json
  def destroy
    @bot.destroy
    respond_to do |format|
      format.html { redirect_to bots_url, notice: 'Bot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bot
      @bot = Bot.custom_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bot_params
      params.require(:bot).permit(:name, :avatar)
    end
end
