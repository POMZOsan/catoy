module AdminLoginMacros
  def admin_login(admin)
    visit admin_login_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: 'admin_password'
    click_button 'ログイン'
  end
end