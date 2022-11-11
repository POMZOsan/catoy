require 'aws-sdk-s3'

SitemapGenerator::Sitemap.default_host = "https://www.catoy.site"
SitemapGenerator::Sitemap.sitemaps_host = "https://#{Rails.application.credentials.dig(:aws, :sitemap_bucket)}.s3.#{Rails.application.credentials.dig(:aws, :region)}.amazonaws.com"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  Rails.application.credentials.dig(:aws, :sitemap_bucket).to_s,
  aws_access_key_id: Rails.application.credentials.dig(:aws, :access_key_id).to_s,
  aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key).to_s,
  aws_region: Rails.application.credentials.dig(:aws, :region).to_s,
)
SitemapGenerator::Sitemap.create do
  add reviews_path
  add ranking_path
  Review.find_each do |review|
    add review_path(review), lastmod: review.updated_at
  end
end
