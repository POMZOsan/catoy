module ApplicationHelper
  def page_title(page_title = '', admin = false)
    if admin
      base_title = 'catoy(管理画面)'
    else
      base_title = 'catoy'
    end
    page_title.empty? ? base_title : page_title + ' * ' + base_title
  end
end
