module TweetsHelper
  def twitter_share(review)
    if current_user.mine?(review)
      "https://twitter.com/intent/tweet?text=【#{review.product.name}】%0aのレビューを投稿しました！&hashtags=catoy,猫のおもちゃ"
    else
      "https://twitter.com/intent/tweet?text=【#{review.product.name}】%0aが気になる！&hashtags=catoy,猫のおもちゃ"
    end
  end
end