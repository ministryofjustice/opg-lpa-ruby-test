require 'spec_helper'
if ENV["INTEGRATION"]
feature 'Filling in an LPA' do

  before(:all) { WebMock.disable! }
  after(:all)  { WebMock.enable! }

  scenario 'create an account' do
    visit "/users/sign_up"
    fill_in_sign_up
    click_button "I understand"
    expect(page).to have_content('Please check your email')
  end

end
end
