class ContactsController < ApplicationController

    def new
        @contact = Contact.new
        set_meta_tags title: "Contact",
            description: "お問い合わせフォーム",
            noindex: true
    end

    def create
        contact = Contact.new(contact_params)
        if contact
            ContactMailer.contact_mail(contact).deliver
            redirect_to new_contact_path, notice: "お問い合わせを受け付けました"
        else
            redirect_to new_contact_path
        end
    end

    def contact_params
        params.require(:contact).permit(:name, :email, :title, :message)
    end
end
