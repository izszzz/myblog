class ApplicationController < ActionController::Base
    before_action :set_header_q

    def set_header_q
        @header_q = Post.ransack()
    end
end
