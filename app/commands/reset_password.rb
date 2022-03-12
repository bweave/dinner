class ResetPassword
  attr_reader :password_params
  attr_reader :user

  def initialize(password_params:, user:)
    @password_params = password_params
    @user = user
  end

  def call
    return Result.new(:not_found) if user.blank?
    return Result.new(:unconfirmed) if user.unconfirmed?
    return Result.new(:expired_token) if user.password_reset_token_has_expired?

    if user.update(password_params)
      Result.new(:success)
    else
      Result.new(:error)
    end
  end

  Result = Struct.new(:status) do
    def ok?
      status == :success
    end
  end
end
