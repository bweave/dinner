class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :household
  attribute :ignore_scoped_to_household

  resets do
    Time.zone = nil
  end

  # def household=(household)
  #   super
  #   # TODO: add time_zone to User
  #   Time.zone = household&.time_zone
  # end
end
