class Invitation < ApplicationRecord
  include ScopedToHousehold

  TOKEN_EXPIRATION_IN_SECONDS = 2.weeks.to_i

  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id", default: -> { User.current }
  belongs_to :household, inverse_of: :invitations, default: -> { Household.current }
  belongs_to :user, optional: true

  has_secure_token :token

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  accepts_nested_attributes_for :user

  def send_invitation_email
    regenerate_token
    update_columns(sent_at: Time.current)
    mailer_params = { invitation: self, household: household, invited_by: created_by }
    InvitationMailer.with(mailer_params).invite.deliver_later
  end

  def expired_token?
    return true if accepted_at.present?

    (Time.current - sent_at) > TOKEN_EXPIRATION_IN_SECONDS
  end
end
