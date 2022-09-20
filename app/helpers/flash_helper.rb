module FlashHelper

  def flash_type(msg_type)
    case msg_type
      when 'info' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-error'
      when 'warning' then 'alert alert-warning'
    end
  end
end