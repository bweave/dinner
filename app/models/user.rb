class User < ApplicationRecord
  include ScopedToHousehold

  CONFIRMATION_TOKEN_EXPIRATION_IN_SECONDS = 10.minutes.to_i
  MAILER_FROM_EMAIL = "howdy@bweave.dev".freeze
  PASSWORD_RESET_TOKEN_EXPIRATION_IN_SECONDS = 10.minutes.to_i

  has_many :recipes_created, class_name: "Recipe", foreign_key: "created_by_id", dependent: :nullify
  has_many :menus_created, class_name: "Menu", foreign_key: "created_by_id", dependent: :nullify
  has_many :invitations_created, class_name: "Invitation", foreign_key: "created_by_id", dependent: :destroy

  accepts_nested_attributes_for :household

  attr_accessor :current_password

  has_secure_password
  has_secure_token :confirmation_token
  has_secure_token :password_reset_token
  has_secure_token :remember_token
  has_secure_token :session_token

  before_save :downcase_email
  before_save :downcase_unconfirmed_email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :unconfirmed_email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }

  def self.current
    Current.user
  end

  def self.current=(user)
    Current.user = user
  end

  # TODO: this will be in Rails 7.1, remove it after upgrading
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def self.authenticate_by(attributes)
    passwords, identifiers = attributes.to_h.partition do |name, _value|
      !has_attribute?(name) && has_attribute?("#{name}_digest")
    end.map(&:to_h)

    raise ArgumentError, "One or more password arguments are required" if passwords.empty?
    raise ArgumentError, "One or more finder arguments are required" if identifiers.empty?

    if (record = find_by(identifiers))
      record if passwords.count { |name, value| record.public_send(:"authenticate_#{name}", value) } == passwords.size
    else
      new(passwords)
      nil
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity

  def confirm!
    if unconfirmed_or_reconfirming?
      return false if unconfirmed_email.present? && !update(email: unconfirmed_email, unconfirmed_email: nil)

      update_columns(confirmed_at: Time.current)
    else
      false
    end
  end

  def confirmed?
    confirmed_at.present?
  end

  def reconfirming?
    unconfirmed_email.present?
  end

  def unconfirmed_or_reconfirming?
    unconfirmed? || reconfirming?
  end

  def confirmable_email
    if unconfirmed_email.present?
      unconfirmed_email
    else
      email
    end
  end

  def confirmation_token_is_valid?
    return false if confirmation_sent_at.nil?

    (Time.current - confirmation_sent_at) <= User::CONFIRMATION_TOKEN_EXPIRATION_IN_SECONDS
  end

  def unconfirmed?
    !confirmed?
  end

  def send_confirmation_email!
    regenerate_confirmation_token
    update_columns(confirmation_sent_at: Time.current)
    UserMailer.confirmation(self).deliver_later
  end

  def password_reset_token_has_expired?
    return true if password_reset_sent_at.nil?

    (Time.current - password_reset_sent_at) >= User::PASSWORD_RESET_TOKEN_EXPIRATION_IN_SECONDS
  end

  def send_password_reset_email!
    regenerate_password_reset_token
    update_columns(password_reset_sent_at: Time.current)
    UserMailer.password_reset(self).deliver_now
  end

  def name
    "#{first_name} #{last_name}".squish || email
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def downcase_unconfirmed_email
    return if unconfirmed_email.blank?

    self.unconfirmed_email = unconfirmed_email.downcase
  end
end
