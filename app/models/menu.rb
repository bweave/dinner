class Menu < ApplicationRecord
  has_many :dinner_menus, inverse_of: :menu, dependent: :destroy
  has_many :dinners, through: :dinner_menus

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_at_is_a_monday
  validate :ends_at_is_after_starts_at

  private

  def starts_at_is_a_monday
    starts_at.monday?
  end

  def ends_at_is_after_starts_at
    ends_at.after? starts_at
  end
end
