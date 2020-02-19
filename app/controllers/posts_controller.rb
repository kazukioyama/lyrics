class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  @@user_type = nil
  # GET /posts
  # GET /posts.json
  def index
    @q = Post.ransack(params[:q])
    @@user_type = current_user.role
    if params[:q]
      @posts = @q.result(distinct: true)
    else
      @posts = Post.all
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @like = Like.new
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
    @post = current_user.posts.build(post_params)
    url = params[:post][:youtube_url]
    url = url.last(11)
    @post.youtube_url = url

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
    url = params[:post][:youtube_url]
    url = url.last(11)
    @post.youtube_url = url
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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

  def mypage
    @@user_type = current_user.role
    if @@user_type == '質問者'
      @posts = current_user.posts
    else
    end
  end
    

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :artist, :title, :lyric, :body, :image, :youtube_url, tag_ids: [])
    end
end
