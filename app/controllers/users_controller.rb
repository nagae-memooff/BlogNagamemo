#encoding=utf-8
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

	def show_current_user
		@user = current_user
	end

	def edit_current_user
		@user = current_user
	end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

	def set_portrait_img
		#TODO:1、如果上传非图片文件，或者非png格式怎么处理
		upload_pic_io = params[:portrait_file]
		result = {}
    
		begin
			user_id = current_user.id
			tmp_file_path = "/dev/shm/temp_portrait_#{user_id}_#{rand(0xffffff)}"
      file_path = if Rails.env == 'development'
                    "#{Rails.root}/app/assets/images/portraits/#{user_id}.png"
                  else
                    "/home/nagae-memooff/rails/blog_nagamemo/shared/portraits/#{user_id}.png"
                  end
			save_resize_picture(upload_pic_io, tmp_file_path, file_path)
			result[:status] = 'OK'
			result[:msg] = "成功上传头像"
#     rescue Exception
    rescue ActiveRecord::RecordNotFound
			result[:status] = 'ERR'
			result[:msg] = "上传头像失败"
		end

		respond_to do |format|
			format.html { redirect_to '/edit_me', notice: result[:msg]  }
			format.json { render :json => result.as_json }
		end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :mood)
    end


	def save_resize_picture(uploaded_io, tmp_file_path, file_path)
		require 'RMagick'
		File.open( tmp_file_path, 'wb') do |file|
			file.write(uploaded_io.read)
		end
		img_orig = Magick::Image.read(tmp_file_path).first
		w, h = img_orig.columns, img_orig.rows
		if w > h 
			shaved_off = (w-h).round 
			img = img_orig.crop(Magick::CenterGravity, w-shaved_off, h)
		else 
			shaved_off = (h-w).round 
			img = img_orig.crop(Magick::CenterGravity, w, h-shaved_off)
		end
		img.resize(160, 160).write file_path
		File.delete(tmp_file_path) if File.exist?(tmp_file_path)
	end
end
