require 'spec_helper'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

require 'sidekiq/testing'

RSpec.configure do |config|
  config.before(:each) do
    # Clears out the jobs for tests using the fake testing
    Sidekiq::Worker.clear_all

    if example.metadata[:sidekiq] == :fake
      Sidekiq::Testing.fake!
    elsif example.metadata[:sidekiq] == :inline
      Sidekiq::Testing.inline!
    elsif example.metadata[:type] == :acceptance
      Sidekiq::Testing.inline!
    else
      Sidekiq::Testing.fake!
    end
  end
end

feature 'Generating PDF previews', sidekiq: :inline do

  before(:each) do
    sign_up_and_sign_in
  end

  scenario 'for healthcare with all valid details', :vcr do
    create_healthcare_lpa
    expect(page).to have_content('This LPA covers Health and welfare')

    fill_in_valid_donor
    click_button "Save and continue"

    expect(page).to have_content('Download preview of LPA')

    click_link "Download preview of LPA"

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

    expect(response_headers["Content-Type"]).to eq("application/pdf")
    expect(response_headers["Content-Disposition"]).to eq("inline; filename=\"draft.pdf\"")
  end
end
