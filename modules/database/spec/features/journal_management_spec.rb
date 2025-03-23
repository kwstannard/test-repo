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

  scenario 'a provider wants to view journal entries by all their clients' do
    provider = "Bob"
    create_provider(provider)

    clients = %w[Joe Jill Jeff Josie]
    clients.each {|c| create_client(c) }

    associate_clients_to_provider(clients, provider)

    dates = ['2025-01-01', '2025-05-02', '2025-02-04', '2024-09-10'].map(&:to_time)
    otnm = Time.method(:now)

    clients.zip(dates).each do |(client, date)|
      Time.define_singleton_method(:now) { date }
      visit!('/database/clients')
      click_on client
      click_on "New Journal"
      fill_in "Name", with: "Journal"
      click_button
      fill_in "Text", with: "It is good to be #{client}"
      click_button
      Time.define_singleton_method(:now, &otnm)
    end


    visit!('/database/providers')
    click_on provider
    
    # This is ordered by time
    expect(table_hash("#notes")).to eq([
      {"At"=>"2025-05-02 04:00:00 UTC", "Note"=>"It is good to be Jill"},
      {"At"=>"2025-02-04 05:00:00 UTC", "Note"=>"It is good to be Jeff"},
      {"At"=>"2025-01-01 05:00:00 UTC", "Note"=>"It is good to be Joe"},
      {"At"=>"2024-09-10 04:00:00 UTC", "Note"=>"It is good to be Josie"},
    ])

  end
end
