class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :update, :destroy]
  before_action :authenticate_user  
  # GET /microposts
  def index
    @microposts = Micropost.all

    render json: @microposts
  end

  def mytweets
    posts = current_user.microposts
    my_posts = []
    posts.each do |post|
      my_posts << { content: post.content }
    end
    render json: { my_posts: my_posts }
  end

  def following
    microposts = []
    current_user.following.each do |following_user|
      following_microposts = following_user.microposts
      following_microposts.each do |following_micropost|
        microposts << { content: following_micropost.content, created_at: following_micropost.created_at, following_user: following_user.username}
      end
    end
    render json: { following_posts: microposts}

  end

  # GET /microposts/1
  def show
    render json: @micropost
  end

  # POST /microposts
  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user_id = current_user.id
    if @micropost.save
      render json: @micropost, status: :created, location: @micropost
    else
      render json: @micropost.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /microposts/1
  def update
    if @micropost.update(micropost_params)
      render json: @micropost
    else
      render json: @micropost.errors, status: :unprocessable_entity
    end
  end

  # DELETE /microposts/1
  def destroy
    @micropost.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def micropost_params
      params.require(:micropost).permit(:content, :string)
    end
end
