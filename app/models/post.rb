class Post < ApplicationRecord
    acts_as_taggable_on :tags, :categories
    validates_presence_of :title, :summary, :body
end
