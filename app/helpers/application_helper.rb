module ApplicationHelper
  def page_title(page_title = '', admin = false)
    if admin
      base_title = 'catoy(管理画面)'
    else
      base_title = 'catoy'
    end
    page_title.empty? ? base_title : page_title + ' * ' + base_title
  end

  def default_meta_tags
    {
      site: 'catoy',
      title: 'catoy * 猫ちゃんのお気に入りを見つけよう',
      reverse: true,
      separator: '|',
      description: 'catoyは猫のおもちゃのレビューから猫ちゃんの性格に合うおもちゃを見つけられるサービスです',
      keywords: '猫,おもちゃ,人気,ランキング,レビュー',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon/favicon.ico') },
        { href: image_url('favicon/apple_touch_icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp/ogp_image.jpg'),
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@POMZOsan'
      }
    }
  end
end
