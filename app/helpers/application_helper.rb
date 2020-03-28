module ApplicationHelper
  include Pagy::Frontend

  def current_class?(cur_path)
    return ' active' if request.path == cur_path
    ''
  end
end
