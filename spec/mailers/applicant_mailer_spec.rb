require "spec_helper"

describe ApplicantMailer do
  describe "#email_applicant" do
    let(:applicant) { mock_model Applicant, name: "Test", email: 'test@test.com', applied_on: Date.today }
    let(:mail) { ApplicantMailer.email_applicant(applicant, "Email body") }

    it "renders the subject" do
      expect(mail.subject).to eq( "8th Light Apprenticeship")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([applicant.email])
    end

    it "renders the send email" do
      expect(mail.from).to eq(['noreply@8thlight.com'])
    end

    it "renders the bcc email" do
      expect(mail.bcc).to eq(["dropbox@92013697.8thlight.highrisehq.com"])
    end

    it "renders the body" do
      expect(mail.body).to eq("Email body")
    end
  end
end
