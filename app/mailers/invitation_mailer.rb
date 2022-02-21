class InvitationMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def invite
    @invitation = params.fetch(:invitation)
    @household = params.fetch(:household)
    @invited_by = params.fetch(:invited_by)
    mail to: @invitation.email, subject: "Dinners: invitation to join #{@invitation.household.name}"
  end
end
