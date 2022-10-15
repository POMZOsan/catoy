module CatsHelper
  def cat_type(type)
    case type
      when 'active' then 'badge badge-secondary'
      when 'gentle' then 'badge  badge-accent'
    end
  end
end