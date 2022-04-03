class UsersController < ApplicationController
  before_action :require_admin, only: %i[edit update ban destroy]

  def index
    @users = User.all.order(created_at: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      redirect_to @user, notice: 'User has been updated'
    else
      render :edit
    end
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

  private

  def user_params
    params.require(:user).permit(*User::ROLES)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end
end