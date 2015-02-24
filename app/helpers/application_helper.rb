module ApplicationHelper
  def active_if_current(path)
    'active' if current_page?(path)
  end
  
  def todo_app?
    controller.action_name != 'calculator'
  end

end
