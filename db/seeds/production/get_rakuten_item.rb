require 'rakuten_web_service'

# items[ 猫じゃらし ねずみ トンネル その他] => 楽天24の猫のおもちゃのカテゴリー
items = [
  RakutenWebService::Ichiba::Item.search(genreId: '215363', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '404161', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '215364', shopCode: 'rakuten24'),
  RakutenWebService::Ichiba::Item.search(genreId: '112121', shopCode: 'rakuten24'),
]

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

      if it['itemName'].match?(/けりぐるみ|ケリグルミ|ケリぐるみ|蹴り/)
        kerigurumi_category.rakutens.create(
          name: it['itemName'],
          image: it['mediumImageUrls'][0],
          url: it['itemUrl']
        )
      else
        category.rakutens.create(
          name: it['itemName'],
          image: it['mediumImageUrls'][0],
          url: it['itemUrl']
        )
      end
      count += 1
    end
    break if count > max
    sleep 3
  end
  sleep 3
end
