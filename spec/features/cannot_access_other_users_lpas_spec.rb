require 'spec_helper'

feature 'Cannot access another users LPA' do

  scenario 'attempt to access another users LPA results is unauthorised', :vcr do
    sign_up_and_sign_in
    old_email = @email
    create_financial_lpa
    lpa_url = page.current_url

    page.reset!
    sign_up_and_sign_in
    fill_in_valid_applicant
    click_button "Save and continue"

    visit(lpa_url)

    page.status_code.should == 403
  end

end
