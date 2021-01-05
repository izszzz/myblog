class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: Rails.application.credentials.mailer[:email], subject: "お問い合わせ内容"
    end
end
