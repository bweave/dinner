class DinnerMenu < ApplicationRecord
  include ScopedToHousehold

  belongs_to :recipe, inverse_of: :dinner_menus
  belongs_to :menu, inverse_of: :dinner_menus

  accepts_nested_attributes_for :recipe
end
