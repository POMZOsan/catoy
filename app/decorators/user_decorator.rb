class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :cat

  def has_introduction?
    object.introduction? ? object.introduction : "自己紹介文がありません"
  end
end
