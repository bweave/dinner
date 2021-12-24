class Dinner < ApplicationRecord
  has_rich_text :description
  has_rich_text :ingredients
  has_rich_text :directions
end
