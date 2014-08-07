class History < ActiveRecord::Base
  has_many :his_mats
  has_many :materials, through: :his_mats

  def self.get_random
    history = self.new

    niku = Material.get_random_niku
    yasaitachi = Material.get_random_yasai

    shokuzaitachi = [niku, yasaitachi.first, yasaitachi.last]
    
    shokuzaitachi.each do |shokuzai|
      history.total_price += shokuzai.cook_price
    end

    [ history, shokuzaitachi ]
  end
end
