class PostsController < ApplicationController

  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    #6-3）： 因为post属于group的， @group是为了让post“对号入座”
    @group = Group.find(params[:group_id])
    #6-3）： 对照groups_controller，进行post对group替换
    @post = Post.new(post_params)
    #记录post属于的group
    @post.group = @group
    #记录post发表的user
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
