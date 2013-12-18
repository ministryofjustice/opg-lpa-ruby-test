require 'spec_helper'

feature "Once signed in, don't show sign in or sign up pages" do
  scenario 'signed in user gets redirected to lpas page from sign in page' , :vcr do
    sign_up_and_sign_in
    fill_in_valid_applicant
    click_button "Save and continue"

    visit "/users/sign_in"
    expect(page).to_not have_content('Sign in')
    expect(page).to have_content("You haven't created any LPAs yet")

    visit "/users/sign_up"
    expect(page).to_not have_content('Create an account')
    expect(page).to have_content("You haven't created any LPAs yet")
  end
end