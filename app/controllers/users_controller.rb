class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    user = User.find(params[:cur_id])
    if (params[:flag] == "true")
      user.following_ids.push(params[:id].to_i)
    else
      user.following_ids.delete(params[:id].to_i)
    end
    user.save!
    respond_to do |format|
      format.html { redirect_to "/" }
      format.json { render json: user.following_ids }
    end
  end
end
