require 'spec_helper'

describe Users::RegistrationsController do

  describe 'create' do

    context 'when successful' do
      before do
        @applicant_email_address = 'ex@ample.com'
        client = double
        Author::Client.stub(:new).and_return client
        client.stub(:register).and_return double(code: 201)
      end

      def get_create
        get :create, registration: { email: @applicant_email_address, password: 'password' }
      end

      it 'should create email with applicant email address' do
        SignUpConfirmer.should_receive(:signup_email).with(@applicant_email_address).and_return double(deliver: nil)
        get_create
      end

      it 'should send email' do
        ActionMailer::Base.deliveries.should be_empty
        get_create
        ActionMailer::Base.deliveries.should_not be_empty
      end
    end
  end
end
