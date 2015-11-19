class PostsController < ApplicationController
  def index
    @currentPage = params[:page].to_i
    #render text: "#{@currentPage} || #{params[:page]}"
    redirect_to root_path if request.fullpath == "/posts" || @currentPage == 1

    if browser.mobile?
      postsPerPage = 5
    else
      postsPerPage = 10
    end

    @posts = Post.all.order('created_at DESC').page(params[:page]).per(postsPerPage)
  end

  def show

  end

  def new
  end

  def edit
  end
end
