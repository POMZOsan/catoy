class ReviewDecorator < Draper::Decorator
  delegate_all

  def has_image?
    object.image.attached? ? h.image_tag(object.image) : h.image_tag('board_placeholder')
  end

  def star
    "星#{object.rate}つ"
  end

  def shop
    if object.review_block.product_type == 'Cainz'
      "shop: カインズホーム"
    elsif object.review_block.product_type == 'Rakuten'
      "shop: 楽天24"
    end
  end
end