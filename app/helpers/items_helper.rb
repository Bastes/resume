module ItemsHelper
  def heading(item)
    level = 
    content_tag "h#{item.level + 2}" do
      h(item.title)
    end
  end
end
