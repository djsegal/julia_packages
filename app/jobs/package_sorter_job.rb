class PackageSorterJob < ApplicationJob
  queue_as :default

  def perform(params={}, cookies={})
    @sort = cookies[:sort] || 'top'
    set_core_query params, cookies

    case @sort
    when 'top'
      set_top_packages
    when 'new'
      set_new_packages
    when 'a_z'
      set_a_z_packages
    when 'z_a'
      set_z_a_packages
    when 'hot'
      set_hot_packages
    else
      raise "Invalid sorting method."
    end

    [@sort, @packages]
  end

  private

    def set_top_packages
      @packages = @core_query.order("counters.stargazer desc")
    end

    def set_new_packages
      @packages = @core_query.order("daters.created desc")
    end

    def set_a_z_packages
      @packages = @core_query.order("LOWER(name) asc")
    end

    def set_z_a_packages
      @packages = @core_query.order("LOWER(name) desc")
    end

    def set_hot_packages
      binary_created_ordering = "daters.created > "
      binary_created_ordering += ActiveRecord::Base.sanitize(1.months.ago)

      @packages = @core_query
        .order(binary_created_ordering)
        .order("daters.touched desc")
        .order("activities.recent_commit_count desc")
    end

    def set_core_query params, cookies
      category = get_category params
      organization = get_organization params
      user = get_user params

      if category.present?
        @core_query = category.packages
      elsif organization.present?
        @core_query = organization.owned_packages
      elsif user.present?
        @core_query = user.supported_packages
      else
        @core_query = Package
      end

      set_cutoff_values cookies

      @core_query = @core_query
        .active_batch_scope
        .page(params[:page])
        .includes(:activity)
        .includes(:dater)
        .includes(:counter)
        .joins(:counter)

      return unless params[:search].present?

      like_word = Rails.env.production? ? 'ILIKE' : 'LIKE'

      @core_query = @core_query.where \
        "name #{like_word} ?", "%#{params[:search]}%"
    end

    def set_cutoff_values cookies
      @core_query = @core_query.where(
        'counters.stargazer >= ?', cookies[:min_stars]
      ) if cookies[:min_stars].present?

      @core_query = @core_query.where(
        'counters.stargazer <= ?', cookies[:max_stars]
      ) if cookies[:max_stars].present?

      @core_query = @core_query.where(
        'daters.touched >= ?', cookies[:start_date]
      ) if cookies[:start_date].present?

      @core_query = @core_query.where(
        'daters.touched <= ?', cookies[:end_date]
      ) if cookies[:end_date].present?
    end

    def get_category params
      return unless params[:category_id].present?
      return unless Category.custom_exists? params[:category_id]

      Category.custom_find params[:category_id]
    end

    def get_organization params
      return unless params[:organization_id].present?
      return unless Organization.custom_exists? params[:organization_id]

      Organization.custom_find params[:organization_id]
    end

    def get_user params
      return unless params[:user_id].present?
      return unless User.custom_exists? params[:user_id]

      User.custom_find params[:user_id]
    end

end
