require 'spec_helper'

feature 'Generating PDF previews' do

  before(:each) do
    sign_up_and_sign_in
  end

  pending 'for healthcare with all valid details', :vcr do
    create_healthcare_lpa
    expect(page).to have_content('This LPA covers Health and welfare')

    expect(page).to have_content('Download preview of LPA')

    click "Download preview of LPA"

    # expect(page).to have_content('Generating PDF')
  end
end

