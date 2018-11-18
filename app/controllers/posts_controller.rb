class PostsController < ApplicationController
  before_action :find_group
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])

    if current_user != @post.user
      redirect_to group_path(@group), alert: "You have no permission."
    end
  end

  def create
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if @post.save
      redirect_to group_path(@group), notice: "新增文章成功！"
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.group = @group
    if current_user != @post.user
      redirect_to group_path(@group), alert: "You have no permission."
    end
    @post.user = current_user
    if @post.update(post_params)
      redirect_to group_path(@group), notice: "文章修改成功！"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to group_path(@group), alert: "You have no permission."
    else
      @post.destroy
      redirect_to group_path(@group), alert: "文章已删除"
    end
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
