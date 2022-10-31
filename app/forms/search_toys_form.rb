class SearchToysForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :shop_name, :string
  attribute :toy_name, :string

  def search
    if shop_name.present? && toy_name.present?
      include_both(shop_name, toy_name)
    elsif shop_name.present?
      include_shop_name(shop_name)
    elsif toy_name.present?
      include_toy_name(toy_name)
    else
      return nil
    end
  end

  def include_shop_name(shop_name)
    if shop_name == 'all'
      scope = []
      Cainz.all.each { |cainz| scope << cainz }
      Rakuten.all.each { |rakuten| scope << rakuten }
      return scope
    elsif shop_name == 'Cainz'
      scope = Cainz.distinct
      return scope
    elsif shop_name == 'Rakuten'
      scope = Rakuten.distinct
      return scope
    end
  end

  def include_toy_name(toy_name)
    cainz_scope = Cainz.where('name LIKE ?', "%#{toy_name}%")
    rakuten_scope = Rakuten.where('name LIKE ?', "%#{toy_name}%")
    if cainz_scope.present? && rakuten_scope.present?
      scope = []
      cainz_scope.each { |cainz| scope << cainz }
      rakuten_scope.each { |rakuten| scope << rakuten }
      return scope
    elsif cainz_scope.present?
      return scope = cainz_scope
    elsif rakuten_scope.present?
      return scope = rakuten_scope
    end
  end

  def include_both(shop_name, toy_name)
    if shop_name == 'all'
      cainz_scope = Cainz.where('name LIKE ?', "%#{toy_name}%")
      rakuten_scope = Rakuten.where('name LIKE ?', "%#{toy_name}%")
      scope = []
      cainz_scope.each { |cainz| scope << cainz }
      rakuten_scope.each { |rakuten| scope << rakuten }
      return scope
    elsif shop_name == 'Cainz'
      scope = Cainz.distinct
      scope = scope.where('name LIKE ?', "%#{toy_name}%")
      return scope
    elsif shop_name == 'Rakuten'
      scope = Rakuten.distinct
      scope = scope.where('name LIKE ?', "%#{toy_name}%")
      return scope
    end
  end
end