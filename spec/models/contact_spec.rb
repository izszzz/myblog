require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) {Contact.new(name: "name", email: "a@a", title:"title", message: "message")}

  context "should be" do
    it "valid" do
      expect(contact).to be_valid
    end

    context "invalid without" do
      it "name" do
        contact.name = ""
        expect(contact).to be_invalid
      end

      it "email" do
        contact.email = ""
        expect(contact).to be_invalid
      end

      it "title" do
        contact.title = ""
        expect(contact).to be_invalid
      end

      it "message" do
        contact.message = ""
        expect(contact).to be_invalid
      end
    end

  end
end
