class UsersController < ApplicationController
  before_action :require_admin, only: %i[ban destroy]
  before_action :require_admin_or_owner, only: %i[edit update]

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
    if @user == current_user
      redirect_to @user, alert: 'You can not ban yourself silly'
    else
      if @user.access_locked?
        @user.unlock_access!
      else
        @user.lock_access!
      end
      redirect_to @user, notice: "User account has been #{@user.access_locked? ? "locked" : "unlocked" }"
    end
  end

  def destroy
    @user = @User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User has been deleted'
  end

  private

  def user_params
    list_allowed_params = []
    list_allowed_params += [:name] if current_user == @user
    list_allowed_params += [*User::ROLES] if current_user.admin?
    params.require(:user).permit(list_allowed_params)
    # params.require(:user).permit(*User::ROLES, :name)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized"
    end
  end

  def require_admin_or_owner
    @user = User.find(params[:id])
    unless current_user.admin? || current_user == @user
      redirect_to root_path, alert: "You are not authorized to perform this action"
    end
  end
end