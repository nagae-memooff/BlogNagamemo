class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :pwd
      t.string :mood

      t.timestamps
    end
  end
end
