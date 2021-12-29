class Dinner < ApplicationRecord
  has_many :dinner_menus, inverse_of: :dinner, dependent: destroy
  has_many :menus, through: :dinner_menus

  validates :name, presence: true

  has_rich_text :description
  has_rich_text :ingredients
  has_rich_text :directions
end
