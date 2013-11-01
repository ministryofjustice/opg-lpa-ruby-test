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
    click_button "Save and continue"
    expect(page).to have_content('is too short')
  end

  scenario 'valid financial with multiple attorneys and replacement attorneys and a person to be told' do
    create_financial_lpa
    expect(page).to have_content('This LPA covers Property and financial affairs')

    # Donor info
    fill_in_valid_person
    click_button "Save and continue"

    expect(page).to have_content('The donor is Mr Johnny Smithson')

    # When it can be used
    expect(page).to have_content('When can your LPA be used?')
    expect(page).to_not have_content('life sustaining treatment')
    choose("as soon as it's registered (with my consent)")
    click_button "Save and continue"

    expect(page).to have_content("The LPA can be used as soon as it's registered")

    # Attorneys
    expect(page).to have_content("Who are your attorneys?")

    2.times do
      click_link 'Add an attorney'
      fill_in_valid_person(:first_name => "Dave", :last_name => "Jameson")

      click_button "Save details"
      expect(page).to have_content("Dave Jameson")
    end
    click_link "Save and continue"

    expect(page).to have_content("The attorneys are Mr Dave Jameson and Mr Dave Jameson")

    # How attorneys should make decisions
    expect(page).to have_content("How should your attorneys make decisions?")
    choose('Jointly and Severally')
    click_button "Save and continue"

    expect(page).to have_content("The attorneys will act jointly and severally")

    # Replacement attorneys
    expect(page).to have_content("Do you want any replacement attorneys?")

    click_link 'Add a replacement attorney'
    fill_in_valid_person(:first_name => "Bob", :last_name => "")
    click_button "Save details"
    expect(page).to have_content("can't be blank")

    fill_in_valid_person(:first_name => "Bob", :last_name => "Man")
    click_button "Save details"
    expect(page).to have_content("Bob Man")

    click_link 'Add a replacement attorney'
    fill_in_valid_person(:first_name => "Bob", :last_name => "Man")
    click_button "Save details"

    click_link "Save and continue"

    expect(page).to have_content("The replacement attorneys are Mr Bob Man and Mr Bob Man")

    # How replacement attorneys should make decisions
    expect(page).to have_content("How should your replacement attorneys make decisions?")
    select('Jointly and Severally', :from => "How replacement attorneys act")
    click_button "Save and continue"

    expect(page).to have_content("The replacement attorneys will act jointly and severally")

    # Certificate provider
    expect(page).to have_content("Who is the certificate provider?")
    fill_in_valid_person(:first_name => "Charlie", :last_name => "Prover")
    click_button "Save and continue"

    expect(page).to have_content('The certificate provider is Mr Charlie Prover')

    # Who to be told
    expect(page).to have_content("Who should be told before your LPA is registered?")
    click_link 'Add a person to be told'
    fill_in_valid_person(:first_name => "Jill", :last_name => "Graham")
    click_button "Save and continue"
    expect(page).to have_content('Mr Jill Graham')
    click_link 'Add a person to be told'
    fill_in_valid_person(:first_name => "Bob", :last_name => "Graham")
    click_button "Save and continue"
    expect(page).to have_content('Mr Bob Graham')

    click_link "Save and continue"

    expect(page).to have_content('The people to be told are Mr Jill Graham and Mr Bob Graham')

    # Completion
    expect(page).to have_content("LPA created")
  end

  scenario 'valid financial with 1 attorneys and 1 attorneys and no person to be told' do
    create_financial_lpa
    expect(page).to have_content('This LPA covers Property and financial affairs')

    # Donor info
    fill_in_valid_person
    click_button "Save and continue"

    expect(page).to have_content('The donor is Mr Johnny Smithson')

    # When it can be used
    expect(page).to have_content('When can your LPA be used?')
    expect(page).to_not have_content('life sustaining treatment')
    choose("as soon as it's registered (with my consent)")
    click_button "Save and continue"

    expect(page).to have_content("The LPA can be used as soon as it's registered")

    # Attorneys
    expect(page).to have_content("Who are your attorneys?")

    click_link 'Add an attorney'
    fill_in_valid_person(:first_name => "Dave", :last_name => "Jameson")

    click_button "Save details"
    expect(page).to have_content("Dave Jameson")
    click_link "Save and continue"

    expect(page).to have_content("The attorney is Mr Dave Jameson")

    # Replacement attorneys
    expect(page).to have_content("Do you want any replacement attorneys?")

    click_link 'Add a replacement attorney'
    fill_in_valid_person(:first_name => "Bob", :last_name => "Man")
    click_button "Save details"
    expect(page).to have_content("Bob Man")

    click_link "Save and continue"

    expect(page).to have_content("The replacement attorney is Mr Bob Man")

    # Certificate provider
    expect(page).to have_content("Who is the certificate provider?")
    fill_in_valid_person(:first_name => "Charlie", :last_name => "Prover")
    click_button "Save and continue"

    expect(page).to have_content('The certificate provider is Mr Charlie Prover')

    # Who to be told
    expect(page).to have_content("Who should be told before your LPA is registered?")
    click_link "Save and continue"

    expect(page).to have_content("There are no 'people to be told'")

    # Second Certificate provider
    expect(page).to have_content("Who is the second certificate provider?")
    fill_in_valid_person(:first_name => "Gregg", :last_name => "John")
    click_button "Save and continue"

    expect(page).to have_content('The second certificate provider is Mr Gregg John')

    # Completion
    expect(page).to have_content("LPA created")
    click_link "Save and continue"
    expect(page).to have_content("Next steps")
 end

  scenario 'healthcare with all valid details' do
    create_healthcare_lpa
    expect(page).to have_content('This LPA covers Health and welfare')

    # Donor info
    fill_in_valid_person
    click_button "Save and continue"

    # Life sustaining treatment decision
    expect(page).to have_content('The donor is Mr Johnny Smithson')
    expect(page).to_not have_content('When to use')
    expect(page).to have_content('Can your attorneys give or refuse consent to life-sustaining treatment?')
    choose("Option B")
    click_button "Save and continue"

    expect(page).to have_content("The attorneys can't make decisions about life-sustaining treatment on the donor's behalf")
  end


  scenario 'financial with invalid donor' do
    create_financial_lpa
    expect(page).to have_content('This LPA covers Property and financial affairs')

    fill_in_valid_person(:first_name => "")
    click_button "Save and continue"
    expect(page).to have_content('is too short')
  end


  def create_financial_lpa(overides={})
    visit "/"
    fill_in_valid_person(overides)
    click_button "Save and continue"

    click_button "Create a new LPA"

    expect(page).to have_content('What type of LPA do you want to create?')
    choose("Property and financial affairs")

    click_button "Save and continue"
  end

  def create_healthcare_lpa(overides={})
    visit "/"
    fill_in_valid_person(overides)
    click_button "Save and continue"

    click_button "Create a new LPA"

    expect(page).to have_content('What type of LPA do you want to create?')
    choose("Health and welfare")

    click_button "Save and continue"
  end


end
end
