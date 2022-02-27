class ResetPassword
  include ActiveModel::Validations

  attr_accessor :user, :redirect

  validates :user, presence: { message: "We couldn't find a user with that password reset token." }
  validate :user_is_confirmed
  validate :password_reset_token_is_unexpired

  def initialize(password_reset_token:)
    @user = User.find_by(password_reset_token: password_reset_token)
  end

  def call(password_params)
    return Result.new(redirect: redirect, message: { alert: user.errors.full_messages.to_sentence }) if invalid?

    if user.update(password_params)
      Result.new(redirect: login_path, message: { success: "Password updated successfully" })
    else
      Result.new(redirect: edit_password_url, message: { alert: user.errors.full_messages.to_sentence })
    end
  end

  private

  Result = Struct.new(:redirect, :message)

  def user_is_confirmed
    return if user.confirmed?

    @redirect = new_confirmation_path
    errors.add(:user, "You must confirm your email before you can sign in.")
  end

  def password_reset_token_is_unexpired
    return if @user.password_reset_token_has_expired?

    @redirect = new_password_path
    errors.add(:user, "Expired password reset token.")
  end
end
