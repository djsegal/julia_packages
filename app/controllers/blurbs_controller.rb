class BlurbsController < ApplicationController
  before_action :set_blurb, only: [:show, :edit, :update, :destroy]

  # GET /blurbs
  # GET /blurbs.json
  def index
    @blurbs = Blurb.all
  end

  # GET /blurbs/1
  # GET /blurbs/1.json
  def show
  end

  # GET /blurbs/new
  def new
    @blurb = Blurb.new
  end

  # GET /blurbs/1/edit
  def edit
  end

  # POST /blurbs
  # POST /blurbs.json
  def create
    @blurb = Blurb.new(blurb_params)

    respond_to do |format|
      if @blurb.save
        format.html { redirect_to @blurb, notice: 'Blurb was successfully created.' }
        format.json { render :show, status: :created, location: @blurb }
      else
        format.html { render :new }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blurbs/1
  # PATCH/PUT /blurbs/1.json
  def update
    respond_to do |format|
      if @blurb.update(blurb_params)
        format.html { redirect_to @blurb, notice: 'Blurb was successfully updated.' }
        format.json { render :show, status: :ok, location: @blurb }
      else
        format.html { render :edit }
        format.json { render json: @blurb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blurbs/1
  # DELETE /blurbs/1.json
  def destroy
    @blurb.destroy
    respond_to do |format|
      format.html { redirect_to blurbs_url, notice: 'Blurb was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blurb
      @blurb = Blurb.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blurb_params
      params.require(:blurb).permit(:cargo)
    end
end
