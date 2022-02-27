module ScopedToHousehold
  extend ActiveSupport::Concern

  included do
    self.primary_key = :id
    belongs_to :household
    before_validation :ensure_scoped_to_household
    default_scope { scoped_to_household_default_scope }
  end

  module ClassMethods
    def scoped_to_household_default_scope
      if ScopedToHousehold.ignore?
        all
      elsif Household.current.blank?
        raise "You must set Household.current to access #{name} or use unscoped"
      else
        where(household_id: Household.current.id)
      end
    end

    def without_user_scope
      unscope(where: :household_id)
    end
  end

  def self.with(household)
    Current.set(household: household, ignore_scoped_to_user: false) { yield }
  end

  def self.ignore
    Current.set(user: nil, ignore_scoped_to_household: true) { yield }
  end

  def self.start_ignoring!
    Current.ignore_scoped_to_household = true
  end

  def self.finish_ignoring!
    Current.ignore_scoped_to_household = false
  end

  def self.ignore?
    Current.ignore_scoped_to_household
  end

  def ensure_scoped_to_household
    return if ScopedToHousehold.ignore?

    if Household.current.blank? && blank_household_id?
      raise "You must set Household.current to save #{self} or set user_id"
    end

    self.household_id = Household.current.id if new_record?
  end

  def blank_household_id?
    household_id.blank? || household_id.zero?
  end
end
