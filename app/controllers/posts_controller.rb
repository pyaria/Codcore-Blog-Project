class PostsController < ApplicationController
  def index
    @currentPage = params[:page].to_i
    redirect_to root_path if request.fullpath == "/posts" || @currentPage == 1

    @posts = Post.all.order('created_at DESC').page(params[:page]).per(5)


    @popularPosts = Post.limit(5).order("created_at, views ASC")
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    # render text: params
    @post = Post.new allowed_post_params
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]

    if @post.update allowed_post_params
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to root_path
  end

  private

  def allowed_post_params
    params.require(:post).permit(:title, :body, {tag_ids: []})
  end
end
