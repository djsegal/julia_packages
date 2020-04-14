class ApplicationController < ActionController::Base
  include Pagy::Backend
  after_action :track_action

  def set_packages package_scope
    cur_search = params[:s] || params[:search]

    if params[:sort].present? && params[:order].present?
      package_scope = package_scope.order(params[:sort] => params[:order])
    else
      if params[:sort] == "name"
        package_scope = package_scope.order(params[:sort] => :asc)
      elsif params[:sort].present?
        package_scope = package_scope.order(params[:sort] => :desc)
      elsif !cur_search.present?
        if @category.present? && @category.name == "Trending"
          package_scope = package_scope.order(updated: :desc)
        else
          package_scope = package_scope.order(stars: :desc)
        end
      end
    end

    if cur_search.present?
      if params[:depth] == "shallow"
        package_scope = package_scope.shallow_search(cur_search)
      else
        package_scope = package_scope.deep_search(cur_search)
      end
    end

    if params[:since].present?
      since_date = Date.strptime(params[:since], "%m-%Y") - 1.day
      package_scope = package_scope.where('updated > ?', since_date)
    end

    if params[:min_stars].present?
      package_scope = package_scope.where('stars > ?', params[:min_stars])
    end

    @pagy, @packages = pagy_countless(
      package_scope, link_extra: 'data-remote="true"'
    )
  end

  protected

    def track_action
      ahoy.track "view", request.path_parameters
    end

end
