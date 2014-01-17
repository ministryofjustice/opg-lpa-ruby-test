require "spec_helper"

describe SignUpConfirmer do

  def read_fixture(action)
    IO.readlines(File.dirname(__FILE__) + "/../fixtures/sign_up_confirmer/signup_email").join
  end

  describe 'signup_email' do

    let(:applicant_email) { 'applicant@example.com' }
    let(:confirmation_url) { 'http://testhost/users/confirmations/xxvFLfedlj' }

    before do
      @email = SignUpConfirmer.signup_email(applicant_email, confirmation_url).deliver
    end

    it 'should have correct "from" field' do
      sender_email = ENV['SENDER_EMAIL']
      sender_email_address = sender_email.sub("'Sender' <",'').chomp('>')

      @email.from.should == [ sender_email_address ]
      @email.to_s.should include( sender_email )
    end

    it 'should have correct "to" field' do
      @email.to.should == [ applicant_email ]
    end

    it 'should have correct body' do
      @email.body.to_s.should == read_fixture('signup_email')
    end
  end
end
