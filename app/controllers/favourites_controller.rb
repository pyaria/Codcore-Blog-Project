class FavouritesController < ApplicationController
  def create
    fav = current_user.favourites.new
    @post = Post.find params[:post_id]
    fav.post = @post
    respond_to do |f|
      if fav.save
        f.html { redirect_to post_path(@post) }
        f.js { render :fav_add }
      else
        f.html { redirect_to post_path(@post) }
        f.js { render js: "alert(\"error\")" }
      end
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    fav = current_user.favourites.find params[:id]
    fav.destroy
    respond_to do |f|
      f.html{ redirect_to post_path(@post) }
      f.js { render :fav_remove}
    end
  end
end
