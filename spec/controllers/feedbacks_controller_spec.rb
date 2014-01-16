require 'spec_helper'

describe FeedbacksController do
  it "displays feedback form" do
    get :new
    response.should render_template('feedbacks/new')
    response.should be_success
  end

  let :form_params do
      {
        :feedback => {
          "rating" => 5,
          "text" => "what a beautiful site",
          "email" => "hermajesty@imperialawesomeness.com"
          },
      "browser" => "Chrome",
      "service" => "Tribunals",
      "referrer" => "some-page-on-the-site"
      }
  end

  before :each do
    NotificationsMailer.default to: "test@dsd.io", from: "test@dsd.io"
  end

  it "redirects to show page on successful feedback submission" do
    post :create, form_params 
    response.should redirect_to feedback_path
  end

  it "sends notification email on successful feedback submission" do
    expect {
      post :create, form_params
    }.to change{ ActionMailer::Base.deliveries.size }.by(1)
  end
end
