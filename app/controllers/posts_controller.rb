#encoding: utf-8
class PostsController < ApplicationController
  include ActionView::Helpers::TextHelper

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :save_file, only: [:create, :update]
  before_action :add_view_count, only: [:index]
  cattr_reader :per_page, :comment_per_page

  @@per_page = 5
  @@comment_per_page = 10
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:user).paginate(page: params[:page], per_page: @@per_page)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @page = params[:page] || "1"
    @comments = Comment.includes(:user).where(post_id: @post.id).paginate(page: @page, per_page: @comment_per_page)
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
    
    @page = params[:page] || "1"
    @comments = Comment.includes(:user).where(post_id: @post.id).paginate(page: @page, per_page: @@comment_per_page)

    redirect_to @post
#     render 'show'
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
    upload_failed_msg = @failed_files.blank? ? "" : "But upload #{pluralize(@failed_files.count, "file")} failed."
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.#{upload_failed_msg}" }
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

  def search
    @keywords = params[:search_keywords].split

    posts_list = {} and posts_list.default = 0
    all_posts = []


    @keywords.each do |keyword|
      Post.includes(:user).where("title like ? or content like ?", "%#{keyword}%", "%#{keyword}%").each do |post|
        posts_list[post] += 1
      end
    end

    posts_array = (posts_list.sort_by {|key, value| value }).reverse

    posts_array.each { |post, count| all_posts << post ; logger.info post; logger.info count }
    logger.info posts_list

#     @posts = paginate_posts all_posts, page
    @posts = all_posts

    @msg = if @posts.count == 0
             "没有符合条件的日志！"
           else
             "找到#{@posts.count}条记录"
           end

    render 'index'
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

  def save_file
    uploaded_files = params[:files]
    @failed_files = []

    uploaded_files.each do |uploaded_file|
      file_name = "#{Date.today.to_s}_#{uploaded_file.original_filename}"
      file_path = "/home/nagae-memooff/rails/blog_nagamemo/shared/files/#{file_name}"

      begin
        FileRecord.create(file_name: file_name, user_id: current_user.id, post_id: @post.id)
        File.open(file_path, 'wb') do |file|
          file.write(uploaded_file.read)
        end
      rescue Exception
        @failed_files << uploaded_file.original_filename
      end
    end
  end

  # FIXME:没有考虑到同一用户多次浏览主页时重复计数的问题
  def add_view_count
    view_count = ViewCount.first
    if current_user != User.first
      view_count.count += 1
      view_count.today_count += 1
      view_count.save
    end
    view_count
  end
end
