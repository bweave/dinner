class Menu < ApplicationRecord
  has_many :dinner_menus, inverse_of: :menu, dependent: :destroy
  has_many :dinners, through: :dinner_menus

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_at_is_a_monday
  validate :ends_at_is_after_starts_at

  accepts_nested_attributes_for :dinner_menus

  after_create do
    dinners.touch_all(:last_suggested_at)
  end

  def title
    "Week of #{starts_at.strftime("%D")}"
  end

  def this_week?
    starts_at == Time.current.beginning_of_week
  end

  def dinner_menus_attributes=(attributes)
    attributes.values.map do |attrs|
      dinner_id = attrs.dig("dinner_attributes", "id").to_i
      dinner_menus.find_or_initialize_by(dinner_id: dinner_id)
    end
  end

  private

  def starts_at_is_a_monday
    starts_at.monday?
  end

  def ends_at_is_after_starts_at
    ends_at.after? starts_at
  end
end
