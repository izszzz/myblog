class ApplicationController < ActionController::Base
    before_action :set_header_q
    before_action :set_seo

    def set_seo
      set_meta_tags canonical: request.original_url
    end

    def set_header_q
        @header_q = Post.ransack()
    end
end
