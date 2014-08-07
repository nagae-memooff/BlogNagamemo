class HisMat < ActiveRecord::Base
  belongs_to :history
  belongs_to :material
end
