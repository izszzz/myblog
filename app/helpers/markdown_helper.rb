require 'rouge/plugins/redcarpet'

module MarkdownHelper
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
  

  def markdown text
    options = { 
      filter_html: true,
      with_toc_data: true,
    }
    extensions = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      space_after_headers: true,
    }
    renderer = HTML.new options
    markdown = Redcarpet::Markdown.new renderer, extensions
    markdown.render(text).html_safe
  end
end