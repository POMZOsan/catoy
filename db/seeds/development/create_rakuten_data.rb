require 'csv'

file_name = %w[ nekojarashi nezumi kerigurumi tonnel other ]
categories = Category.all

categories.each.with_index do |category, i|
  puts "#{category.name}のデータをDBに保存中..."

  CSV.foreach("db/seeds/csv/#{file_name[i]}.csv", encoding: "UTF-8") do |row|
    category.rakutens.create(
      name: row[0], # 商品名
      image: row[1], # 画像url 
      url: row[2] # 商品url
    )
  end
end