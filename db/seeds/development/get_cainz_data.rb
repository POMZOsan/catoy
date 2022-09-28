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
  category_url = []
  page = agent.get(url)
  elements = page.search('.m-goodslist_ttl a')
  elements.each do |ele|
    category_url << "https://www.cainz.com" + ele.get_attribute(:href)
  end
# 1.5~3秒ごとにアクセス
  sleep rand(1.5..3.0)
  urls.push category_url
end

mouse_category = Category.find(2) # ねずみ系のカテゴリー

urls.each.with_index(1) do |url, i|
  if i == 2
    i = 3
  elsif i == 3
    i = 5
  end
  
  category = Category.find(i)
  url.each do |u|
    page = agent.get(u) 
    image_src = page.search('.m-productGallery li').at('img').get_attribute(:src)
    name = page.at('.m-hdg1').inner_text

    if name.match?(/ねずみ|ネズミ|マウス/)
      mouse_category.cainzs.create(name: name, image: image_src, url: u )
    else
      category.cainzs.create(name: name, image: image_src, url: u )
    end
    # 1.5~3秒ごとにアクセス
    sleep rand(1.5..3.0)
  end
end
