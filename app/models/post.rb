class Post < ApplicationRecord
    acts_as_taggable_on :tags, :categories
end
