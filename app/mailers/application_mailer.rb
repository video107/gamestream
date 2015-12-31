class ApplicationMailer < ActionMailer::Base
  default from: "StreamCircle<noreply@streamcircle.net>"
  layout 'mailer'

  helper :application
end
