class Menu < ApplicationRecord
  include ScopedToHousehold

  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  has_many :dinner_menus, inverse_of: :menu, dependent: :destroy
  has_many :recipes, through: :dinner_menus

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_at_is_a_monday
  validate :ends_at_is_after_starts_at

  after_create do
    recipes.touch_all(:last_suggested_at)
  end

  def title
    "Week of #{starts_at.strftime("%D")}"
  end

  def this_week?
    starts_at == Time.current.beginning_of_week
  end

  def dinner_menus_attributes=(attributes)
    attributes.values.map do |attrs|
      recipe_id = attrs.dig("recipe_attributes", "id").to_i
      dinner_menus.find_or_initialize_by(recipe_id: recipe_id)
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
