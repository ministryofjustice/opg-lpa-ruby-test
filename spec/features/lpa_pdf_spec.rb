require 'spec_helper'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

feature 'Generating PDF previews', :js => true do

  before(:each) do
    sign_up_and_sign_in
    system("rm -f pdfs/drafts/*.pdf")
  end

  after(:each) do
    system("rm -f pdfs/drafts/*.pdf")
  end

  scenario 'for healthcare with all valid details', :vcr do
    create_healthcare_lpa
    expect(page).to have_content('This LPA covers Health and welfare')

    fill_in_valid_donor
    click_button "Save and continue"

    expect(page).to have_content('Download preview of LPA')

    click_link "Download preview of LPA"
    sleep(10)

    expect(response_headers["Content-Type"]).to eq("application/pdf")
    expect(response_headers["Content-Disposition"]).to eq("inline; filename=\"draft.pdf\"")
  end

  scenario 'for financial with all valid details', :vcr do
    create_financial_lpa
    expect(page).to have_content('This LPA covers Property and financial affairs')

    fill_in_valid_donor
    click_button "Save and continue"

    expect(page).to have_content('Download preview of LPA')

    click_link "Download preview of LPA"
    sleep(10)

    expect(response_headers["Content-Type"]).to eq("application/pdf")
    expect(response_headers["Content-Disposition"]).to eq("inline; filename=\"draft.pdf\"")
  end
end
