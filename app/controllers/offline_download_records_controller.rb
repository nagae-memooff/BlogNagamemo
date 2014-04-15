#encoding=utf-8
class OfflineDownloadRecordsController < ApplicationController
  before_action :set_offline_download_record, only: [:show, :edit, :update, :destroy, :log, :status, :download]

  # GET /offline_download_records
  # GET /offline_download_records.json
  def index
    @offline_download_records = OfflineDownloadRecord.includes(:user).all
  end

  # GET /offline_download_records/1
  # GET /offline_download_records/1.json
  def show
    #     client_download_file @offline_download_record
  end

  # GET /offline_download_records/new
  def new
    @offline_download_record = OfflineDownloadRecord.new user_id: current_user.id
  end

  # GET /offline_download_records/1/edit
  def edit
    render text: "无此操作", status: "404"
  end

  # POST /offline_download_records
  # POST /offline_download_records.json
  def create
    #     @offline_download_record = OfflineDownloadRecord.new(offline_download_record_params)
    @offline_download_record = current_user.offline_download_records.new(offline_download_record_params)

    respond_to do |format|
      if @offline_download_record.save
        format.html { redirect_to @offline_download_record, notice: '已添加下载任务，请稍后下载。' }
        format.json { render action: 'show', status: :created, location: @offline_download_record }
      else
        format.html { render action: 'new' }
        format.json { render json: @offline_download_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offline_download_records/1
  # PATCH/PUT /offline_download_records/1.json
  def update
    respond_to do |format|
      if @offline_download_record.update(offline_download_record_params)
        format.html { redirect_to @offline_download_record, notice: 'Offline download record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @offline_download_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offline_download_records/1
  # DELETE /offline_download_records/1.json
  def destroy
    @offline_download_record.destroy
    respond_to do |format|
      format.html { redirect_to offline_download_records_url }
      format.json { head :no_content }
    end
  end

  def log
    respond_to do |format|
      format.html { render text: @offline_download_record.log }
      format.json { render text: @offline_download_record.log }
    end
  end

  def status
    render text: @offline_download_record.status
  end

  def download
    begin
      send_file @offline_download_record.local_file_path, disposition: "attachment"
    rescue ActionController::MissingFile
      respond_to do |f|
        f.html { render text: "服务器上找不到此文件，可能它已被删除。", status: 404 }
        f.json { render json: {code: 404, msg: "服务器上找不到此文件，可能它已被删除"}}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_offline_download_record
    @offline_download_record = OfflineDownloadRecord.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def offline_download_record_params
    params.require(:offline_download_record).permit(:url, :file_name, :retry_times, :user_id, :description)
  end
end
