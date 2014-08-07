class RenameTypeToMType < ActiveRecord::Migration
  def change
    rename_column :materials, :type, :m_type
  end
end
