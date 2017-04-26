module ApplicationHelper
  def styled_link(path, number_of_users, definition)
    link_to(path) { "<strong> #{number_of_users} </strong> #{definition}".html_safe }
  end
end
