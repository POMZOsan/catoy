class ReviewBlockSerializer < ActiveModel::Serializer
  attributes :shop, :name, :image, :url, :rate, :count
  
  def shop
    case object.product_type
      when "Cainz" then "カインズホーム"
      when "Rakuten" then "楽天24"
    end
  end

  def name
    case object.product_type
      when "Cainz" then toy = Cainz.find(object.product_id)
      when "Rakuten" then toy = Rakuten.find(object.product_id)
    end
    toy.name
  end

  def image
    case object.product_type
      when "Cainz" then toy = Cainz.find(object.product_id)
      when "Rakuten" then toy = Rakuten.find(object.product_id)
    end
    toy.image
  end

  def url
    case object.product_type
      when "Cainz" then toy = Cainz.find(object.product_id)
      when "Rakuten" then toy = Rakuten.find(object.product_id)
    end
    toy.url
  end

  def rate
    object.review.rate
  end

  def count
    ReviewBlock.where(product_type: object.product_type, product_id: object.product_id).count
  end
end
