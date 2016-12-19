class ReadmesController < ApplicationController
  before_action :set_readme, only: [:show, :edit, :update, :destroy]

  # GET /readmes
  # GET /readmes.json
  def index
    @readmes = Readme.all
  end

  # GET /readmes/1
  # GET /readmes/1.json
  def show
  end

  # GET /readmes/new
  def new
    @readme = Readme.new
  end

  # GET /readmes/1/edit
  def edit
  end

  # POST /readmes
  # POST /readmes.json
  def create
    @readme = Readme.new(readme_params)

    respond_to do |format|
      if @readme.save
        format.html { redirect_to @readme, notice: 'Readme was successfully created.' }
        format.json { render :show, status: :created, location: @readme }
      else
        format.html { render :new }
        format.json { render json: @readme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /readmes/1
  # PATCH/PUT /readmes/1.json
  def update
    respond_to do |format|
      if @readme.update(readme_params)
        format.html { redirect_to @readme, notice: 'Readme was successfully updated.' }
        format.json { render :show, status: :ok, location: @readme }
      else
        format.html { render :edit }
        format.json { render json: @readme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readmes/1
  # DELETE /readmes/1.json
  def destroy
    @readme.destroy
    respond_to do |format|
      format.html { redirect_to readmes_url, notice: 'Readme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_readme
      @readme = Readme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def readme_params
      params.require(:readme).permit(:file_name, :cargo, :package_id)
    end
end
