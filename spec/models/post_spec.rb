require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {Post.first}
  context "should be" do
    it "valid" do
      expect(post).to be_valid
    end

    context "invalid without" do
      it "title" do
        post.title = ""
        expect(post).to be_invalid
      end

      it "summary" do
        post.summary = ""
        expect(post).to be_invalid
      end

      it "body" do
        post.body = ""
        expect(post).to be_invalid
      end
    end
  end
end
