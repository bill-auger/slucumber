require "spec_helper"

describe SlMailer do

  context "new confirmation email" do
    before(:each) do
      @client = FactoryGirl.create(:client)
    end

    it "should render successfully" do
      lambda { SlMailer.sl_email(@client) }.should_not raise_error
    end

    it "should include correct headers" do
      @an_email = SlMailer.sl_email(@client)
      @an_email.from.should have_content(NOREPLY_EMAIL)
      @an_email.to.should have_content(SL_PROXY_EMAIL)
      @an_email.subject.should have_content(CONFIRMATION_EMAIL_SUBJECT)
    end

    context "rendered without error" do
      before(:each) do
        @an_email = SlMailer.sl_email(@client)
      end

      it "should contain the Client nick" do
        @an_email.body.should have_content(@client.nick)
      end

      it "should deliver successfully" do
        lambda { @an_email.deliver }.should_not raise_error
      end

      describe "and delivered" do
        it "should be added to the delivery queue" do
          expect { @an_email.deliver }.to change(ActionMailer::Base.deliveries,:size).by(1)
        end
      end
    end

  end

end
