class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: "izszzz@yahoo.co.jp", subject: "お問い合わせ内容"
    end
end
