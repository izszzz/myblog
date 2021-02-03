class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: Rails.application.credentials.yahoo[:user_name], subject: "izszzz-blog お問い合わせ内容"
    end
end
