require "spec_helper"

describe Notifier do
  describe "introduction email" do

    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    let(:user) { create(:user) }
    let(:mail) { Notifier.introduction(user) }

    it 'should send an email' do
      mail.deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'should set the subject to the correct subject' do
      expect(mail.subject).to eq('Welcome to Graceful Hoppers!')
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(["graceful.hoppers@gmail.com"])
    end
  end
end
