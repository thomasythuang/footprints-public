class ApplicantMailer < ActionMailer::Base
  default :from => "noreply@footprints.com",
          :reply_to => "brad@footprints.com"

  def email_applicant(applicant, email_body)
    @applicant = applicant
    mail(to: @applicant.email,
         body: email_body,
         content_type: "text/html",
         subject: "Footprints Job")
  end
end
