class ViewCount < ActiveRecord::Base
  def self.increament
    v = ViewCount.fetch
    ViewCount.increment_counter :count, v.id
    ViewCount.increment_counter :today_count, v.id
    v.count += 1
    v.today_count += 1
    Rails.cache.write :view_count, v
  end

  def self.fetch
    view_count = Rails.cache.read :view_count
    if view_count.nil?
      view_count = ViewCount.first || ViewCount.create
      Rails.cache.write :view_count, view_count
    end

    view_count
  end

  def self.reset_today
    view_count = self.fetch
    view_count.today_count = 0
    view_count.save
    Rails.cache.write :view_count, view_count
  end
end
