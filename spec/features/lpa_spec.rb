require 'spec_helper'
if ENV["INTEGRATION"]
feature 'Filling in an LPA' do
  before(:each) do
    WebMock.disable!
  end
  after(:each) do
    WebMock.enable!
  end

  scenario 'with invalid applicant' do
    visit "/"
    fill_in_valid_person(:first_name => "")
    click_button "Save details"
    expect(page).to have_content('is too short')
  end

  scenario 'financial with all valid details' do
    create_financial_lpa
    expect(page).to have_content('This LPA covers Property and financial affairs')

    fill_in_valid_person
    click_button "Save and continue"

    expect(page).to have_content('The donor is Mr Johnny Smithson')
    expect(page).to have_content('When to use')
    expect(page).to_not have_content('life sustaining treatment')

    click_button "Save and continue"

    expect(page).to have_content("The LPA can be used as soon as it's registered")
    expect(page).to have_content("Who are your attorneys?")
    fill_in_valid_person(:first_name => "Dave", :last_name => "Jameson")
    click_button "Save and continue"

    expect(page).to have_content("The attorney is Mr Dave Jameson")
    expect(page).to have_content("LPA created")
  end

  scenario 'healthcare with all valid details' do
    create_healthcare_lpa
    expect(page).to have_content('This LPA covers Health and welfare')

    fill_in_valid_person
    click_button "Save and continue"

    expect(page).to have_content('The donor is Mr Johnny Smithson')
    expect(page).to_not have_content('When to use')
    expect(page).to have_content('Life sustaining treatment')

    click_button "Save and continue"

    expect(page).to have_content("The attorneys can't make decisions about life-sustaining treatment on the donor's behalf")
    expect(page).to have_content("Who are your attorneys?")
    fill_in_valid_person(:first_name => "Dave", :last_name => "Jameson")
    click_button "Save and continue"

    expect(page).to have_content("The attorney is Mr Dave Jameson")
    expect(page).to have_content("LPA created")
  end


  scenario 'financial with invalid donor' do
    create_financial_lpa
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

  def create_financial_lpa(overides={})
    visit "/"
    fill_in_valid_person(overides)
    click_button "Save details"

    click_button "Create a new LPA"

    expect(page).to have_content('Type')
    select("Property and financial affairs", :from => "Type")

    click_button "Save and continue"
  end

  def create_healthcare_lpa(overides={})
    visit "/"
    fill_in_valid_person(overides)
    click_button "Save details"

    click_button "Create a new LPA"

    expect(page).to have_content('Type')
    select("Health and welfare", :from => "Type")

    click_button "Save and continue"
  end


end
end
