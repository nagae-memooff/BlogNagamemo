class AddTodayCountToViewCount < ActiveRecord::Migration
  def change
    add_column :view_counts, :today_count, :integer, default: 0
  end
end
