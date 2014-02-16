class FileRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def file_link
    self.file_name
  end
end
