module ItemsHelper
  def heading(item)
    content_tag "h#{item.level + 1}" do
      textilize_without_paragraph item.title
    end
  end
end
