class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  # GET /settings.json
  def index
    settings_list = %w[
      has_discourse_news
      has_reddit_news
      has_github_news
      sidebar_select
      min_stars
      max_stars
      start_date
      end_date
      sort
    ]

    if params[:clear_cookies]
      clear_all_cookies settings_list
    else
      update_all_cookies settings_list
    end

    prev_url = request.env['HTTP_REFERER']
    prev_url ||= request.base_url

    has_www = params['has_www']
    replace_subdomain = has_www ? 'www.' : ''
    prev_url.sub! 'cdn.', replace_subdomain

    cookies.permanent['needs_refresh'] = true

    redirect_to prev_url
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.fetch(:setting, {})
    end

    def fix_filter_pairs new_settings
      min_stars = new_settings[:min_stars] && new_settings[:min_stars].to_i
      max_stars = new_settings[:max_stars] && new_settings[:max_stars].to_i

      needs_stars_flip = min_stars.present? && max_stars.present?
      needs_stars_flip &&= ( min_stars > max_stars )

      if needs_stars_flip
        new_settings[:min_stars], new_settings[:max_stars] = \
          new_settings[:max_stars], new_settings[:min_stars]
      end

      start_date = new_settings[:start_date] && new_settings[:start_date].to_date
      end_date = new_settings[:end_date] && new_settings[:end_date].to_date

      needs_date_flip = start_date.present? && end_date.present?
      needs_date_flip &&= ( start_date > end_date )

      if needs_date_flip
        new_settings[:start_date], new_settings[:end_date] = \
          new_settings[:end_date], new_settings[:start_date]
      end
    end

    def clear_all_cookies settings_list
      settings_list.each do |cur_setting|
        cookies.delete cur_setting
      end
    end

    def update_all_cookies settings_list
      new_settings = params.select {
        |p| settings_list.include? p
      }.to_unsafe_hash

      new_settings.each do |k, v|
        new_settings[k] = nil \
          unless v.present?
      end

      fix_filter_pairs new_settings

      new_settings.each do |k, v|
        cookies.permanent[k] = v
      end
    end
end
