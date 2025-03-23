RSpec.feature 'client journaling' do
  scenario 'a client can write a journal' do
    client = "Bob"
    create_client(client)

    visit!('/database/clients')
    click_on client

    click_on 'New Journal'

    fill_in 'Name', with: "Affirmations"
    click_button

    fill_in "Text", with: "I am great"
    click_button

    click_on "New Note"
    fill_in "Text", with: "I am competent"
    click_button

    expect(page).to have_text("Affirmations")
    within("#notes") {
      expect(page).to have_text("I am great")
      expect(page).to have_text("I am competent")
    }

    click_on client

    click_on "New Journal"
    fill_in 'Name', with: 'Diet'
    click_button

    fill_in 'Text', with: "Grapefruit"
    click_button

    click_on "New Note"
    fill_in 'Text', with: "Burger"
    click_button

    expect(page).to have_text("Diet")
    within("#notes") {
      expect(page).to have_text("Burger")
      expect(page).to have_text("Grapefruit")
    }

    # Check links
    click_on client
    click_on "Affirmations"
    click_on client
    click_on "Diet"
    click_on client
  end
end
