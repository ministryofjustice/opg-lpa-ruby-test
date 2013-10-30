require 'spec_helper'

feature 'Filling in an LPA' do
  before(:each) do
    WebMock.disable!
  end
  after(:each) do
    WebMock.enable!
  end
  scenario 'with all valid details' do
    visit "/"
    fill_in_valid_person
    click_button "Save details"

    click_button "Create a new LPA"

    expect(page).to have_content('Type')

    click_button "Save and continue"

    expect(page).to have_content('This LPA covers Property and financial affairs')

    fill_in_valid_person
    click_button "Save and continue"
    expect(page).to have_content("These are all the LPAs that you've created")
  end

  scenario 'with all invalid donor' do
    visit "/"
    fill_in_valid_person
    click_button "Save details"

    click_button "Create a new LPA"

    expect(page).to have_content('Type')

    click_button "Save and continue"

    expect(page).to have_content('This LPA covers Property and financial affairs')

    fill_in_valid_person(:first_name => "")
    click_button "Save and continue"
    expect(page).to have_content('is too short')
 end


  def fill_in_valid_person(overides={})
    fill_in 'First name', with: overides[:first_name] || "Johnny"
    fill_in 'Last name', with: overides[:last_name] || "Smithson"
    fill_in 'Post code', with: overides[:post_code] || "SW1H 9AJ"
    fill_in 'Address line1', with: overides[:address_line1] || "102 Petty France"
    fill_in 'Town', with: overides[:town] || "Westminster"
    fill_in 'County', with: overides[:county] || "London"
    fill_in 'Country', with: overides[:country] || "Great Britain"
  end

end
