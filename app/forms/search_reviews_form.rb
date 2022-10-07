class SearchReviewForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title_or_content, :string
  attribute :product_name, :string
  attribute :category_name, :string

  def search
    scope = Review.distinct
    scope = scope.title_contain(title_or_content).or(scope.content_contain(title_or_content)) if title_or_content.present?
    scope = scope.cainz_products(product_name).or(scope.rakuten_products(product_name)) if product_name.present?
    scope = scope.cainz_category(category_name).or(scope.rakuten_category(category_name)) if category_name.present?
    scope
  end
end
