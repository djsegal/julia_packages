class DatersController < ApplicationController
  before_action :set_dater, only: [:show, :edit, :update, :destroy]

  # GET /daters
  # GET /daters.json
  def index
    @daters = Dater.all
  end

  # GET /daters/1
  # GET /daters/1.json
  def show
  end

  # GET /daters/new
  def new
    @dater = Dater.new
  end

  # GET /daters/1/edit
  def edit
  end

  # POST /daters
  # POST /daters.json
  def create
    @dater = Dater.new(dater_params)

    respond_to do |format|
      if @dater.save
        format.html { redirect_to @dater, notice: 'Dater was successfully created.' }
        format.json { render :show, status: :created, location: @dater }
      else
        format.html { render :new }
        format.json { render json: @dater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daters/1
  # PATCH/PUT /daters/1.json
  def update
    respond_to do |format|
      if @dater.update(dater_params)
        format.html { redirect_to @dater, notice: 'Dater was successfully updated.' }
        format.json { render :show, status: :ok, location: @dater }
      else
        format.html { render :edit }
        format.json { render json: @dater.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daters/1
  # DELETE /daters/1.json
  def destroy
    @dater.destroy
    respond_to do |format|
      format.html { redirect_to daters_url, notice: 'Dater was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dater
      @dater = Dater.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dater_params
      params.require(:dater).permit(:created, :updated, :pushed, :package_id)
    end
end
