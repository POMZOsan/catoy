module ReviewsHelper
  def rating_parcent(rate)
    if rate.present?
      cal = rate.to_f / 5 * 100
      parcent = cal.round
      return parcent
    else
      return 0
    end
  end
end