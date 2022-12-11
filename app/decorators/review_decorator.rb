class ReviewDecorator < Draper::Decorator
  delegate_all

  def image
    object.image.attached? ? object.image : 'defaults/board_placeholder.png'
  end

  def star
    "星#{object.rate}つ"
  end

  def shop
    if object.review_block.blank?
      "該当するショップがありません"
    else
      if object.review_block.product_type == 'Cainz'
        "カインズホーム"
      elsif object.review_block.product_type == 'Rakuten'
        "楽天24"
      end
    end
  end
end