#encoding=utf-8
class OfflineDownloadRecord < ActiveRecord::Base
  include OfflineDownloadRecordsHelper

  before_create :download_file_to_server
  belongs_to :user

#   STATUS = { 0 => "任务已建立", 1 => "下载中", 2 => "下载完毕", -1 => "下载出错" }

  def log
    # TODO:错误处理逻辑
    log_command = "cat #{self.local_log_path}"
    log = `#{log_command}`
    log
  end

  def status
    status = case status_code
             when 2
               "已完成"
             when 1
               status_command = "tail -n 2 #{self.local_log_path}"
               status = `#{status_command}`
               if (/.* saved \[[0-9\/]+\]/ =~ status)
                 self.update_attribute(:status_code, 2)
                 update_download_info
                 "已完成"
               else
                 # TODO:返回值改为指示进度
                 "下载中"
               end
             else
               "出错"
             end
      status
  end

  def redownload
    # TODO:重新下载
  end

  def local_file_path
    local_file_path = "#{download_dir}/#{self.file_name}"
    local_file_path
  end

  def local_log_path
    local_log_path = "#{download_dir}/#{self.file_name}_log"
    local_log_path
  end

  def desc
    desc = self.description.blank? ? "该文件没有写描述" : self.description
    desc
  end

  private
  def download_dir
     "#{Rails.root}/public/download_files/user_#{self.user_id}"
  end

  def update_download_info
    file_size = readable(File.size(self.local_file_path))

    info = `tail -n 2 #{self.local_log_path}`
    /([0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}) \(([0-9.]+ [KM]B\/s)\) .*saved \[[0-9\/]+\]/ =~ info
    attributes = { finished_at: $1, aver_speed: $2, file_size: file_size }

    self.update_attributes attributes
  end

  def download_file_to_server
    # TODO:错误处理
    Dir.mkdir(download_dir) unless File.directory? download_dir
    download_command = "wget -c -o #{self.local_log_path} -O #{self.local_file_path} -b -N -t #{retry_times} #{url}"
    `#{download_command}` and self.status_code = 1
  end
end
