class StaticPagesController < ApplicationController
  def home
  end

  def about
    set_meta_tags title: "About"
  end

  def privacy
    set_meta_tags title: "Privacy"
  end

end
