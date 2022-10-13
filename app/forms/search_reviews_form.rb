class SearchReviewsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :category_name, :string

  def search
    scope = Review.distinct
    # カテゴリー、キーワード両方で検索
    if keyword.present? && category_name.present?
      # カテゴリー検索
      category_reviews_ids = scope.category_reviews_ids(category_name)
      # 商品名検索
      product_reviews_ids = scope.product_reviews_ids(keyword)

      result_ids = category_reviews_ids && product_reviews_ids
      result = scope.find(result_ids)

      return result

    elsif category_name.present?
      category_reviews_ids = scope.category_reviews_ids(category_name)
      category_result = scope.order(created_at: :desc).find(category_reviews_ids)

      return category_result

    elsif keyword.present?
      product_reviews_ids = scope.product_reviews_ids(keyword)
      product_result = scope.find(product_reviews_ids)

      return product_result
    end
  end
end
