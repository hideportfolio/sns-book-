# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'hidehis111@gmail.com'

  def send_confirm_to_user(user)
    @user = user
    mail(
      subject: '会員登録が完了しました。', # メールのタイトル
      to: @user.email, &:text # 宛先
    )
  end

  def notify_user
    #@user = user
    mail(bcc: User.pluck(:email), subject:"ご連絡")
    #mail to: user.email, subject:"新規登録完了のご連絡"
  end
end
