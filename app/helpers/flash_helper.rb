module FlashHelper

  def flash_type(msg_type)
    case msg_type
      when 'notice' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-error'
      when 'alert' then 'alert alert-alert'
    end
  end
end