class PostsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new edit create update destroy]
  before_action :set_tags, only: %i[show tags index]
  before_action :set_categories, only: %i[show categories]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page])
    set_meta_tags title: "Posts",
      description: "記事一覧"
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @tags = @tags.last(8)
    @categories = @categories.last(8)
    @q = Post.ransack(params[:q])
    set_meta_tags title: @post.title,
      description: @post.summary
  end

  def autocomplete
    q = Post.ransack(params[:q])
    posts = q.result(distinct: true).last(5)
    render json: posts
  end

  def tags
  end

  def categories
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.'}
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_tags
      @tags = Post.tags_on(:tags)
    end

    def set_categories
      @categories = Post.tags_on(:categories)
    end
    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :summary, :body, :tag_list, :category_list)
    end

end
