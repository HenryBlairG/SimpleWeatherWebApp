# frozen_string_literal: true

# Base mailer class
class ApplicationMailer < ActionMailer::Base
  default from: 'from@weather-app.com'
  layout 'mailer'
end
