#email
class ApplicationMailer < ActionMailer::Base
  default from: "noreply@socialmusic.com"
  layout 'mailer'
end
