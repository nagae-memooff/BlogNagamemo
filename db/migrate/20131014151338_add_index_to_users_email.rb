class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
		add_index :users, :email, unique: true
		rename_column :users, :pwd, :password_digest
  end
end
