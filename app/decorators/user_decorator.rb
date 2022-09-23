class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :cat

  def has_avatar?
    object.avatar.attached? ? h.image_tag(object.avatar) : h.image_tag('sample.jpg')
  end

  def cat_has_avatar?
    object.cat.avatar.attached? ? h.image_tag(object.cat.avatar) : h.image_tag('sample.jpg')
  end

  def has_introduction?
    object.introduction? ? object.introduction : "自己紹介文がありません"
  end
end
