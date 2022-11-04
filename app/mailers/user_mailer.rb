class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    @q_form = 'https://forms.gle/xMmE2TZDJYbiBJrm9'
    mail to: user.email, subject: t('defaults.password_reset')
  end
end
