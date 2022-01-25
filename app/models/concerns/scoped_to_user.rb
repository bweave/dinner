module ScopedToUser
  extend ActiveSupport::Concern

  included do
    self.primary_key = :id
    belongs_to :user
    before_validation :ensure_scoped_to_user
    default_scope { scoped_to_user_default_scope }
  end

  module ClassMethods
    def scoped_to_user_default_scope
      if ScopedToUser.ignore?
        all
      elsif User.current.blank?
        fail "You must set User.current to access #{name} or use unscoped"
      else
        where(user_id: User.current.id)
      end
    end

    def without_user_scope
      unscope(where: :user_id)
    end
  end

  def self.with(user)
    Current.set(user: user, ignore_scoped_to_user: false) { yield }
  end

  def self.ignore
    Current.set(user: nil, ignore_scoped_to_user: true) { yield }
  end

  def self.start_ignoring!
    Current.ignore_scoped_to_user = true
  end

  def self.finish_ignoring!
    Current.ignore_scoped_to_user = false
  end

  def self.ignore?
    Current.ignore_scoped_to_user
  end

  def ensure_scoped_to_user
    return if ScopedToUser.ignore?

    raise "You must set user.current to save #{self} or set user_id" if User.current.blank? && blank_user_id?

    self.user_id = user.current.id if new_record?
  end

  def blank_user_id?
    user_id.blank? || user_id.zero?
  end
end
