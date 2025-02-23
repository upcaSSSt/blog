class PostsController < ApplicationController
  def index
    if params[:q].present?
      @posts = Post.where("body like ?", "%#{params[:q]}%")
    else
      @posts = Post.where(user_id: current_user.following_ids)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.create! params.require(:post).permit(:body)
    post.images.attach(params[:post][:images])
    redirect_to post
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params.require(:post).permit(:body))
      @post.images.attach(params[:post][:images])
      redirect_to @post
    else
      render :edit, status: :unprocessible_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/"
  end

  def purge_image
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_back fallback_location: "/"
  end
end
