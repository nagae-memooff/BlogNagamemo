class StaticPageController < ApplicationController
  def home
  end

  def about
  end

  def lunar_date
    data = LunarDate.today_data

    render text: data
  end
end
