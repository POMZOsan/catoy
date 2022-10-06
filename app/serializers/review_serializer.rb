class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :rate, :image_url, :product_id, :product_type
end
