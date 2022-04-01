class UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def ban
    @user = User.find(params[:id])
    if @user.access_locked?
      @user.unlock_access!
    else
      @user.lock_access!
    end
    redirect_to @user, notice: "User account has been #{@user.access_locked? ? "locked" : "unlocked" }"
  end

  def destroy
    @user = @User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User has been deleted'
  end
end