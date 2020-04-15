module ApplicationHelper
  include Pagy::Frontend

  def current_class?(cur_path)
    return ' active' if request.path == cur_path
    ''
  end

  def custom_int_to_text(cur_int)
    return 0 if cur_int.zero?

    cur_round = 2 - Math.log10(cur_int).ceil
    rounded_int = cur_int.round(cur_round)

    used_units = {
      thousand: "k", million: "m", billion: "b"
    }

    cur_text = number_to_human(
      rounded_int, format: '%n%u', units: used_units
    )

    cur_text
  end
end
