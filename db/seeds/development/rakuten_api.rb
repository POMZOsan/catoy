require 'rakuten_web_service'
require 'csv'

# items[ 猫じゃらし ねずみ トンネル その他] => 楽天24の猫のおもちゃのカテゴリー
items = [
  RakutenWebService::Ichiba::Item.search(genreId: '215363', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '404161', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '215364', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '112121', shopCode: 'rakuten24'),
]

# カテゴリー分の2次元配列作成
categories = Array.new(5){Array.new}
category_name = %w[ nekojarashi nezumi kerigurumi tonnel other ]

# カテゴリーごとに繰り返し
items.each.with_index do |item, i|
  # 楽天にけりぐるみカテゴリーがない為indexが2になったら次のカテゴリーの処理へ
  i += 1 if i >= 2

  puts "カテゴリー: #{category_name[i]}データ取得中..."

  # 総ページ数をいれる
  entire_page = item.response['pageCount']
  # 1カテゴリーの総商品数
  max = item.response['count']
  # 商品数カウント用
  count = 1

  entire_page.times do |n|
    n += 1
    item.page(n).all do |it|
      break if count > max
      
      # 楽天24のカテゴリーにけりぐるみがないための対策
      if it['itemName'].match?(/けりぐるみ|ケリグルミ|ケリぐるみ|蹴り/)
        categories[2] << [ it['itemName'], it['mediumImageUrls'][0], it['itemUrl']]
      else
        categories[i] << [ it['itemName'], it['mediumImageUrls'][0], it['itemUrl']]
      end
      count += 1
    end
    break if count > max
    sleep 3
  end
  i += 1
  sleep 3
end


categories.each.with_index do |category, name|
  puts "カテゴリー: #{category_name[name]}データcsv書き込み中..."

  CSV.open("db/seeds/csv/#{category_name[name]}.csv", "w") do |csv|
    category.each do |array|
      csv << array
    end
  end
end
