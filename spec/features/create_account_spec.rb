require 'spec_helper'
if ENV["INTEGRATION"]
feature 'Filling in an LPA' do

  before(:all) { WebMock.disable! }
  after(:all)  { WebMock.enable! }

  scenario 'create an account' do
    visit "/users/sign_up"
    fill_in_sign_up
    click_button "I understand"
    expect(page).to have_content('Please check your email')

    click_link "sign in now"
    expect(page).to have_content('Sign in')

    fill_in_sign_in
    click_button "Sign in"
    expect(page).to have_content('About you')

    fill_in_valid_applicant
    click_button "Save and continue"
    expect(page).to have_content('Your LPAs')

    click_button "Create a new LPA"

  end

end
end