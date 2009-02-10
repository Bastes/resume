# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Executes the block's content if and only if the user is admin
  def admin_area(&block)
    if admin?
      yield
    end
  end
end
