class FileRecord < ActiveRecord::Base
  before_destroy :delete_file
  belongs_to :user
  belongs_to :post

  def url
    "/files/#{self.file_name}"
  end

  def delete_file
     File.delete(self.url) if File.exist?(self.url)
  end
end
