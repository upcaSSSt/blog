class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def follow
    current_user.following_ids.push(params[:id].to_i)
    current_user.save!
    redirect_to "/"
  end

  def unfollow
    current_user.following_ids.delete(params[:id].to_i)
    current_user.save!
    redirect_to "/"
  end
end
