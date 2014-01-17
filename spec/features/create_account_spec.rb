require 'spec_helper'

feature 'Sign up and sign in' do

  scenario 'create an account', :vcr do

    visit "/users/sign_up"
    fill_in_sign_up email: ''
    click_button "I understand"
    expect(page).to have_content("can't be blank")

    fill_in_sign_up password: ''
    click_button "I understand"
    expect(page).to have_content("can't be blank")

    fill_in_sign_up
    click_button "I understand"
    expect(page).to have_content('Please check your email')

    confirm_registration

    expect(page).to have_content('Sign in')

    fill_in_sign_in email: ''
    click_button "Sign in"
    expect(page).to have_content("You need to sign in or sign up before continuing")

    fill_in_sign_in password: ''
    click_button "Sign in"
    expect(page).to have_content("Invalid email or password")

    fill_in_sign_in
    click_button "Sign in"
    expect(page).to have_content('About you')

    fill_in_valid_applicant first_name: 'Johnny', last_name: 'Smith'
    click_button "Save and continue"
    expect(page).to have_content('Johnny Smith')
    expect(page).to have_content('Your LPAs')

    click_button "Create a new LPA"
    expect(page).to have_content('Johnny Smith')

    click_link "Sign out"
    expect(page).to_not have_content('Johnny Smith')
    expect(page).to have_content('Make a lasting power of attorney')

    visit '/applicants/new'
    expect(page).to_not have_content('About you')
    expect(page).to have_content('Make a lasting power of attorney')

    click_link "sign in"
    expect(page).to have_content('Sign in')
    fill_in_sign_in
    click_button "Sign in"

    expect(page).to have_content('Johnny Smith')
    expect(page).to_not have_content('About you')
    expect(page).to have_content('Your LPAs')

    visit '/applicants/new'
    expect(page).to_not have_content('About you')
    expect(page).to have_content('Your LPAs')
  end

end
