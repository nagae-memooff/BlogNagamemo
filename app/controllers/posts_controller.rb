#encoding: utf-8
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:user).paginate(page: params[:page], per_page: 5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @page = params[:page] || 1
    @per_page = 10
    @comments = Comment.includes(:user).where(post_id: @post.id).paginate(page: @page, per_page: @per_page)
  end

  # GET /posts/new
  def new
    if signed_in?
      @post = Post.new 
    else
      redirect_to sign_in_path
    end
  end

  # GET /posts/1/edit
  def edit
  end

  def quick_new
    @post = Post.new(title: MDT.date + '随笔' , content: params[:content] , user_id: current_user.id )
    @post.save 
    
    @page = params[:page] || 1
    @per_page = 10
    @comments = Comment.includes(:user).where(post_id: @post.id).paginate(page: @page, per_page: @per_page)

    render 'show'
  end

  def search
    @keywords = params[:search_keywords].split
    @posts = []

    @keywords.each do |keyword|
      @posts |= Post.includes(:user).where("title like ? or content like ?", "%#{keyword}%", "%#{keyword}%")
    end

    @msg = if @posts.count == 0
             "没有符合条件的日志！"
           else
             "找到#{@posts.count}条记录"
           end

    render 'index'
  end
  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.includes(:user).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end
end
