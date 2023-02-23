class GuestSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[ guest_login ]

  def guest_login
    if current_user
      redirect_to root_path, warning: 'すでにログインしています!'
    else
      user = User.find_or_create_by!(name: 'ゲスト', email: 'guest@example.com', role: :guest) do |user|
                user.password = SecureRandom.alphanumeric
                user.password_confirmation = user.password
                user.introduction = 'ゲストユーザーです'
              end
      if user.cat.nil?
        user.create_cat!(name: 'ゲストcat', sex: :female, birth_date: DateTime.new(2022, 2, 22))
      end
      auto_login(user)
      redirect_to root_path, info: 'ゲストでログインしました'
    end
  end
end
