category_name = %w[じゃらし系 ねずみ系 けりぐるみ系 トンネル系 その他]

category_name.each do |name|
  Category.create(name: name)
end