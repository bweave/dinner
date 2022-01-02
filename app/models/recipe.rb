class Recipe < ApplicationRecord
  has_many :dinner_menus, inverse_of: :recipe, dependent: :destroy
  has_many :menus, through: :dinner_menus

  validates :name, presence: true

  has_rich_text :ingredients
  has_rich_text :directions
  has_one_attached :picture do |pic|
    pic.variant :thumb, resize_to_limit: [240, 135]
    pic.variant :medium, resize_to_limit: [640, 360]
    pic.variant :large, resize_to_limit: [1280, 720]
  end
end