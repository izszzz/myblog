class Post < ApplicationRecord
    acts_as_taggable_on :tags, :categories
    validates_presence_of :title, :summary, :body
    def next
        self.class.where("id > ?", id).first
    end

    def prev
        self.class.where("id < ?", id).last
    end

    def related
        self.class.tagged_with(tag_list, any: true)
    end

    def latest(count = 5)
        self.class.last(count).reverse
    end

    def random(count = 4)
        self.class.find(self.class.pluck(:id).sample(count))
    end
end
