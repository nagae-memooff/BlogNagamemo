class CreateLunarDates < ActiveRecord::Migration
  def change
    create_table :lunar_dates do |t|
      t.string :date
      t.string :summary
      t.timestamps
    end
  end
end
