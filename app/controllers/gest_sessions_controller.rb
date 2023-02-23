class GuestSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[ guest_login ]

  def guest_login
  end
end
