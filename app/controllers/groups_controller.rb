class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit
    @group = Group.find(params[:id])
    @group.user = current_user
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    @group = Group.find(params[:id])
    @group.user = current_user
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
    if @group.update(group_params)
      redirect_to groups_path, notice: "修改讨论版成功"
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.user = current_user
    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
    @group.destroy
    redirect_to groups_path, alert: "讨论版已删除"
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
