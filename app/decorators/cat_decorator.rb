class CatDecorator < Draper::Decorator
  delegate_all

  def birth_day
    if object.birth_date.present?
      "#{object.birth_date.strftime("%-m月%-d日")}生まれ #{age}才"
    else
      "生年月日不明"
    end
  end

  def age
    (Date.today.strftime("%Y%m%d").to_i - object.birth_date.strftime("%Y%m%d").to_i) / 10000
  end

  def character
    if object.character == "active"
      "#{object.character_i18n}な性格"
    else
      "#{object.character_i18n}性格"
    end
  end

  def avatar
    object.avatar.attached? ? object.avatar : 'sample.jpg'
  end
end
