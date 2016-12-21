class PackageSorterJob < ApplicationJob
  queue_as :default

  def perform(params)
    @sort = params[:sort] || 'top'
    set_core_query params

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
      live_packages = @core_query.where("daters.created > ?", 1.months.ago)
      dead_packages = @core_query.where.not("daters.created > ?", 1.months.ago)

      @packages = live_packages.or(dead_packages).order("daters.touched desc")
    end

    def set_core_query params
      has_category = params[:category_id].present?
      has_category &&= Category.friendly.exists? params[:category_id]

      if has_category
        category = Category.friendly.find params[:category_id]
        @core_query = category.packages
      else
        @core_query = Package
      end

      @core_query = @core_query
        .page(params[:page])
        .includes(:dater)
        .includes(:counter)
        .joins(:counter)

      return unless params[:search].present?

      like_word = Rails.env.production? ? 'ILIKE' : 'LIKE'

      @core_query = @core_query.where \
        "name #{like_word} ?", "%#{params[:search]}%"
    end

end
