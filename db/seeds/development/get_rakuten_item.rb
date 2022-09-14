require 'rakuten_web_service'

items = RakutenWebService::Ichiba::Item.search(genreId: '206264', shopCode: 'rakuten24')

# 総ページ数をいれる
entire_page = items.response['pageCount']
max = items.response['count']
count = 1 # 商品数カウント

entire_page.times do |n|
  n += 1
  items.page(n).all do |item|
    return if count > max

    Rakuten.create(
      name: item['itemName'],
      image: item['mediumImageUrls'][0],
      url: item['itemUrl']
    )
    count += 1
  end
  sleep 3
end
