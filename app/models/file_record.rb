class FileRecord < ActiveRecord::Base
  before_destroy :delete_file
  belongs_to :user
  belongs_to :post

  def url
    "/files/#{self.file_name}"
  end

  def delete_file
    file_path = "#{Rails.root}/public#{self.url}"
    File.delete(file_path) if File.exist?(file_path)
  end
end
