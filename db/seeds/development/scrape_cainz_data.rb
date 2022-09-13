require 'mechanize'

agent = Mechanize.new

# cainz_urlは[猫じゃらし, ケリぐるみ, その他おもちゃ]の3つのカテゴリーのurlが入っている
cainz_url = [
  "https://www.cainz.com/c/c163230/?prefn1=cainzOriginalFlag&prefv1=true&sz=60",
  "https://www.cainz.com/c/c163232/?prefn1=cainzOriginalFlag&prefv1=true&sz=40",
  "https://www.cainz.com/c/c163238/?prefn1=cainzOriginalFlag&prefv1=true&sz=40"
]

urls = []
cainz_url.each do |url|
  page = agent.get(url)
  elements = page.search('.m-goodslist_ttl a')
  elements.each do |ele|
    urls << "https://www.cainz.com" + ele.get_attribute(:href)
  end
# 1.5~3秒ごとにアクセス
  sleep rand(1.5..3.0)
end

urls.each do |url|
  page = agent.get(url) 
  image_src = page.search('.m-productGallery li').at('img').get_attribute(:src)
  name = page.at('.m-hdg1').inner_text

  Cainz.create(name: name, image: image_src, url: url )
# 1.5~3秒ごとにアクセス
  sleep rand(1.5..3.0)
end