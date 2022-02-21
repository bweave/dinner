class Household < ApplicationRecord
  has_many :users, dependent: :destroy, inverse_of: :household
  has_many :invitations, dependent: :destroy, inverse_of: :household
  has_many :recipes, dependent: :destroy, inverse_of: :household
  has_many :menus, dependent: :destroy, inverse_of: :household
  has_many :dinner_menus, dependent: :destroy, inverse_of: :household

  validates :name, presence: true

  def self.current=(household)
    Current.household = household
  end

  def self.current
    Current.household
  end
end
