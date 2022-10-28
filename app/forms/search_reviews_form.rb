class SearchReviewsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :category_name, :string
  attribute :title_or_content, :string
  attribute :rate, :integer
  attribute :created_at_gteq, :datetime
  attribute :created_at_lteq, :datetime
  attribute :shop, :string

  def search
    scope = Review.distinct
    # カテゴリー、キーワード両方で検索
    if keyword.present? && category_name.present?
      # カテゴリー検索
      category_reviews_ids = scope.category_reviews_ids(category_name)
      # 商品名検索
      product_reviews_ids = scope.product_reviews_ids(keyword)

      result_ids = category_reviews_ids && product_reviews_ids
      result = scope.where(id: result_ids)

      return result

    elsif category_name.present?
      category_reviews_ids = scope.category_reviews_ids(category_name)
      category_result = scope.where(id: category_reviews_ids)

      return category_result

    elsif keyword.present?
      product_reviews_ids = scope.product_reviews_ids(keyword)
      product_result = scope.where(id: product_reviews_ids)

      return product_result
    else
      return scope
    end
  end

  def admin_search
    scope = Review.distinct
    scope = scope.title_contain(title_or_content).or(scope.content_contain(title_or_content)) if title_or_content.present?
    scope = scope.rate_contain(rate) if rate.present?
    scope = scope.created_after(created_at_gteq) if created_at_gteq.present?
    scope = scope.created_before(created_at_lteq) if created_at_lteq.present?
    scope = scope.shop_contain(shop) if shop.present?
    return scope
  end
end
