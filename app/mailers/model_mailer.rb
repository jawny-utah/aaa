# frozen_string_literal: true

class ModelMailer < ApplicationMailer
  default from: 'stmp@mailgun.test'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
  def new_record_notification(user)
    @user = user
    mail to: @user.email.to_s, subject: 'Success! You did it.'
  end
end
