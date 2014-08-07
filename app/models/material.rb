#encoding=utf-8
class Material < ActiveRecord::Base
  has_many :his_mats
  has_many :histories, through: :his_mats

  scope :niku, -> { where(["m_type = ?", "肉"]) }
  scope :yasai, -> { where(["m_type = ?", "菜"]) }
  scope :mada_nokotteru, -> { where(["materials.now > materials.cook_count"])}
  scope :nokottenai, -> {where(["materials.now <= materials.cook_count"])}

  def self.get_random_niku
    Material.mada_nokotteru.niku.find :first, order: "RAND()"
  end

  def self.get_random_yasai
    Material.mada_nokotteru.yasai.find :all, limit: 2, order: "RAND()"
  end

end
