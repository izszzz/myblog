class Contact < ApplicationRecord
    validates_presence_of :name, :email, :title, :message
end
