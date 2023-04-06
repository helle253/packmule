class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('treats@packmule.net', 'Packmule Boulangerie')
  layout 'mailer'
end
