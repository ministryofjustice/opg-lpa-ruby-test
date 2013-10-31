require 'spec_helper'
if ENV["INTEGRATION"]
  feature 'Filling in an LPA' do
    before(:each) do
      WebMock.disable!
    end
    after(:each) do
      WebMock.enable!
    end

    scenario "adding two attorneys" do
      create_financial_lpa_to_attorneys
      click_link 'Add an attorney'
      fill_in_valid_person(:first_name => "Attorney Juan")
      click_button "Save and continue"
      expect(page).to have_content("Attorney Juan")
      click_link 'Add an attorney'
      fill_in_valid_person(:first_name => "Attorney Tulisa")
      click_button "Save and continue"
      expect(page).to have_content("Attorney Juan")
      expect(page).to have_content("Attorney Tulisa")

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

    def create_financial_lpa_to_attorneys(overides={})
      visit "/"
      fill_in_valid_person(overides)
      click_button "Save details"
      click_button "Create a new LPA"
      expect(page).to have_content('Type')
      select("Property and financial affairs", :from => "Type")
      click_button "Save and continue"
      fill_in_valid_person
      click_button "Save and continue"
      click_button "Save and continue"

      expect(page).to have_content("Who are your attorneys?")
    end
  end
end