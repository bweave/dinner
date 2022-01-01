class DinnerMenu < ApplicationRecord
  belongs_to :dinner, inverse_of: :dinner_menus
  belongs_to :menu, inverse_of: :dinner_menus

  accepts_nested_attributes_for :dinner
end
