require 'rakuten_web_service'

# items[ 猫じゃらし ねずみ トンネル その他] => 楽天24の猫のおもちゃのカテゴリー
items = [
  RakutenWebService::Ichiba::Item.search(genreId: '215363', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '404161', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '215364', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '112121', shopCode: 'rakuten24'),
]
# けりぐるみ用にカテゴリー作成
kerigurumi_category = Category.find(3)

items.each.with_index(1) do |item, i|
  i += 1 if i >= 3

  category = Category.find(i)
  # 総ページ数をいれる
  entire_page = item.response['pageCount']
  max = item.response['count']
  count = 1 # 商品数カウント

  entire_page.times do |n|
    n += 1
    item.page(n).all do |it|
      break if count > max
      # 商品名に"(個数)"が含まれ、同じ商品の個数違いが保存されてしまう為の対策
      if item_name = it['itemName'].slice(/(.*?)(?=\()/)
        item_name
      else
        item_name = it['itemName']
      end
      # 楽天24のカテゴリーにけりぐるみがないための対策
      if item_name.match?(/けりぐるみ|ケリグルミ|ケリぐるみ|蹴り/)
        kerigurumi_category.rakutens.find_or_create_by(name: item_name) do |c|
          c.image = it['mediumImageUrls'][0]
          c.url = it['itemUrl']
        end
      else
        category.rakutens.find_or_create_by(name: item_name) do |c|
          c.image = it['mediumImageUrls'][0]
          c.url = it['itemUrl']
        end
      end
      count += 1
    end
    break if count > max
    sleep 3
  end
  sleep 3
end
