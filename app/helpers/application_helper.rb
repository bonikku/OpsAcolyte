module ApplicationHelper

  def boolean_label(value)
    if value
      content_tag(:span, "Yes", class: "badge badge-danger")
    else
      content_tag(:span, "No", class: "badge badge-success")
    end
  end
end
