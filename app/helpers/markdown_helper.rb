require 'rouge/plugins/redcarpet'

module MarkdownHelper
  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    def header(text, level)
      query =URI.encode_www_form_component(text.downcase.gsub(/[\s]/, "-").gsub(/\//, ""))
      case level
      when 1
        %(<h1 id='#{query}'class='mb-5 pb-1 border-bottom'>#{text}</h1>)
      when 2
        %(<h2 id='#{query}' class='mt-5 pb-1 border-bottom'>#{text}</h2>)
      when 3
        %(<h3 id='#{query}' class='mt-5 pb-1 border-bottom'>#{text}</h3>)
      when 4
        %(<h4 id='#{query}' class='mt-5 pb-1 border-bottom'>#{text}</h4>)
      when 5
        %(<h5 id='#{query}' class='mt-5 pb-1 border-bottom'>#{text}</h5>)
      when 6
        %(<h6 id='#{query}' class='mt-5 pb-1 border-bottom'>#{text}</h6>)
      end 
    end
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