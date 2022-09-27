class UserDecorator < Draper::Decorator
  delegate_all

  def avatar
    object.avatar || 'sample.jpg'
  end

  def has_introduction?
    object.introduction? ? object.introduction : "自己紹介文がありません"
  end
end
