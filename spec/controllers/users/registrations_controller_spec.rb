require 'spec_helper'

describe Users::RegistrationsController do

  describe 'create' do

    context 'when successful' do
      it 'should send email' do
        email = 'ex@ample.com'

        ApiClient.stub(:post).and_return double(code: 201)

        SignUpConfirmer.should_receive(:signup_email).with email
        get :create, registration: { email: email, password: 'password' }
      end
    end
  end
end
