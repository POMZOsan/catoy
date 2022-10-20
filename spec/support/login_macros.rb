module LoginMacros
  def login(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'ログイン'
  end
end