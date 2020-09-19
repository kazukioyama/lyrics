class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    binding.pry
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to [@post]
    else
      render 'posts/show'
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to [:post, { id: params[:post_id] }]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :main_id).merge(post_id: params[:post_id])
    end
end
