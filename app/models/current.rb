class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :ignore_scoped_to_user

  resets do
    Time.zone = nil
  end

  def user=(user)
    super
    # TODO: add time_zone to User
    # Time.zone = user&.time_zone
  end
end
