class OwnershipsController < ApplicationController
  before_action :set_ownership, only: [:show, :edit, :update, :destroy]

  # GET /ownerships
  # GET /ownerships.json
  def index
    @ownerships = Ownership.all
  end

  # GET /ownerships/1
  # GET /ownerships/1.json
  def show
  end

  # GET /ownerships/new
  def new
    @ownership = Ownership.new
  end

  # GET /ownerships/1/edit
  def edit
  end

  # POST /ownerships
  # POST /ownerships.json
  def create
    @ownership = Ownership.new(ownership_params)

    respond_to do |format|
      if @ownership.save
        format.html { redirect_to @ownership, notice: 'Ownership was successfully created.' }
        format.json { render :show, status: :created, location: @ownership }
      else
        format.html { render :new }
        format.json { render json: @ownership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ownerships/1
  # PATCH/PUT /ownerships/1.json
  def update
    respond_to do |format|
      if @ownership.update(ownership_params)
        format.html { redirect_to @ownership, notice: 'Ownership was successfully updated.' }
        format.json { render :show, status: :ok, location: @ownership }
      else
        format.html { render :edit }
        format.json { render json: @ownership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ownerships/1
  # DELETE /ownerships/1.json
  def destroy
    @ownership.destroy
    respond_to do |format|
      format.html { redirect_to ownerships_url, notice: 'Ownership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ownership
      @ownership = Ownership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ownership_params
      params.require(:ownership).permit(:user_id, :package_id)
    end
end
