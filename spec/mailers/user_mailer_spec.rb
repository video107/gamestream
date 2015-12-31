require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "notify_withdraw" do
    let(:mail) { UserMailer.notify_withdraw }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify withdraw")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "notify_feedback" do
    let(:mail) { UserMailer.notify_feedback }

    it "renders the headers" do
      expect(mail.subject).to eq("Notify feedback")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
