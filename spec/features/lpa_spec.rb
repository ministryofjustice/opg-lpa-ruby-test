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
    fill_in 'First name', with: "Johnny"
    fill_in 'Last name', with: "Smithson"
    fill_in 'Post code', with: "SW1H 9AJ"
    fill_in 'Address line1', with: "102 Petty France"
    fill_in 'Town', with: "Westminster"
    fill_in 'County', with: "London"
    fill_in 'Country', with: "Great Britain"
    click_button "Save details"

    click_button "Create a new LPA"

    expect(page).to have_content('Type')
    
    click_button "Save and continue"

    expect(page).to have_content('This LPA covers Financial')

    fill_in 'First name', with: "John"
    fill_in 'Last name', with: "Smith"
    fill_in 'Post code', with: "SW1H 9AJ"
    fill_in 'Address line1', with: "102 Petty France"
    fill_in 'Town', with: "Westminster"
    fill_in 'County', with: "London"
    fill_in 'Country', with: "Great Britain"
    click_button "Save and continue"
  end
end
