class PackageSorterJob < ApplicationJob
  queue_as :default

  def perform(params={}, cookies={})
    @sort = params[:sort]
    @sort ||= cookies[:sort]
    @sort ||= 'top'

    @sort.downcase!
    @sort.gsub! '-', "_"

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
    when 'search'
      # uses pg_search sorting
    else
      raise "Invalid sorting method."
    end

    set_search_query params

    [@sort, @packages]
  end

  private

    def set_top_packages
      @packages = @packages.order("counters.stargazer desc")
    end

    def set_new_packages
      @packages = @packages.order("daters.created desc")
    end

    def set_a_z_packages
      @packages = @packages.order("Case When name < 'A' Then -1 Else 1 End < 0")
      @packages = @packages.order("LOWER(name) asc")
    end

    def set_z_a_packages
      @packages = @packages.order("Case When name < 'A' Then -1 Else 1 End > 0")
      @packages = @packages.order("LOWER(name) desc")
    end

    def set_hot_packages
      binary_created_ordering = "daters.created > "
      binary_created_ordering += ActiveRecord::Base.sanitize(1.months.ago)

      @packages = @packages
        .order(binary_created_ordering)
        .order("daters.touched desc")
        .order("activities.recent_commit_count desc")
    end

    def set_core_query params, cookies
      category = get_category params

      organization = get_organization params
      user = get_user params
      bot = get_bot params

      depended_package = get_depended_package params
      dependent_package = get_dependent_package params

      if category.present?
        @packages = category.packages
      elsif organization.present?
        @packages = organization.owned_packages
      elsif user.present?
        @packages = user.supported_packages
      elsif bot.present?
        @packages = bot.owned_packages
      elsif depended_package.present?
        @packages = depended_package.dependents
      elsif dependent_package.present?
        @packages = dependent_package.depending
      else
        @packages = Package
      end

      @packages = @packages.active_batch_scope

      @packages = @packages.exclude_unregistered_packages \
        unless ( cookies[:include_unregistered_packages] == 'true' )

      @packages = @packages
        .includes(:dater)
        .includes(:counter)
        .includes(:activity)
        .joins(:dater)
        .joins(:counter)
        .joins(:activity)

      set_cutoff_values cookies

      @packages = @packages
        .paginate(
          page: params[:page],
          per_page: params[:per_page]
        )
    end

    def set_search_query params
      return unless params[:term].present?

      search_param = params[:term].strip

      @packages = if params[:default_search]

        @packages.where \
          "name ILIKE ?", "%#{ search_param }%"

      elsif params[:autocomplete]

        @packages.shallow_search search_param

      elsif params[:sort] == "search"

        @packages.deep_search search_param

      else

        @packages.sorted_search search_param

      end

    end

    def set_cutoff_values cookies
      @packages = @packages.where(
        'counters.stargazer >= ?', cookies[:min_stars]
      ) if cookies[:min_stars].present?

      @packages = @packages.where(
        'counters.stargazer <= ?', cookies[:max_stars]
      ) if cookies[:max_stars].present?

      @packages = @packages.where(
        'daters.touched >= ?', cookies[:start_date]
      ) if cookies[:start_date].present?

      @packages = @packages.where(
        'daters.touched <= ?', cookies[:end_date]
      ) if cookies[:end_date].present?
    end

    def get_category params
      return unless params[:category_id].present?
      Category.custom_find params[:category_id]
    end

    def get_organization params
      return unless params[:organization_id].present?
      Organization.custom_find params[:organization_id]
    end

    def get_bot params
      return unless params[:bot_id].present?
      Bot.custom_find params[:bot_id]
    end

    def get_user params
      return unless params[:user_id].present?
      User.custom_find params[:user_id]
    end

    def get_depended_package params
      return unless params[:dependent_id].present?
      Package.custom_find params[:dependent_id]
    end

    def get_dependent_package params
      return unless params[:depended_id].present?
      Package.custom_find params[:depended_id]
    end

end
