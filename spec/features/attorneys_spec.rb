require 'spec_helper'

if ENV["INTEGRATION"]
  feature 'Filling in an LPA' do

    before(:each) do
      WebMock.disable!
      visit "/users/sign_up"
      fill_in_sign_up
      click_button "I understand"
      click_link "sign in now"
      fill_in_sign_in
      click_button "Sign in"
    end

    after(:each) do
      WebMock.enable!
    end

    scenario "adding two attorneys" do
      create_financial_lpa_to_attorneys
      click_link 'Add an attorney'
      fill_in_valid_attorney(:first_name => "Attorney Juan")
      click_button "Save details"
      expect(page).to have_content("Attorney Juan")
      click_link 'Add an attorney'
      fill_in_valid_attorney(:first_name => "Attorney Tulisa")
      click_button "Save details"
      expect(page).to have_content("Attorney Juan")
      expect(page).to have_content("Attorney Tulisa")
    end

    def create_financial_lpa_to_attorneys(overides={})
      visit "/"
      fill_in_valid_applicant(overides)
      click_button "Save and continue"
      click_button "Create a new LPA"
      expect(page).to have_content('What type of LPA do you want to create?')
      choose("Property and financial affairs")
      click_button "Save and continue"
      fill_in_valid_donor
      click_button "Save and continue"
      choose("as soon as it's registered (with my consent)")
      click_button "Save and continue"

      expect(page).to have_content("Who are your attorneys?")
    end

    scenario "adding attorney with validation error" do
      create_financial_lpa_to_attorneys
      click_link 'Add an attorney'
      fill_in_valid_person first_name: ""
      click_button "Save details"
      expect(page).to have_content("can't be blank")
      fill_in_valid_person first_name: "Attorney Tulisa"
      click_button "Save details"
      expect(page).to have_content("Attorney Tulisa")

      click_link "Delete"
      expect(page).to_not have_content("Attorney Tulisa")
    end

  end
end