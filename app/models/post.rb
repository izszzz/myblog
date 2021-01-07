class Post < ApplicationRecord
    acts_as_taggable_on :tags, :categories
    validates_presence_of :title, :summary, :body
    def next
        self.class.where("id > ?", id).first
    end

    def prev
        self.class.where("id < ?", id).last
    end
end
