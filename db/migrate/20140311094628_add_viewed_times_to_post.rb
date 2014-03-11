class AddViewedTimesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :viewed_times, :integer, default: 0
  end
end
