require 'rails_helper'

RSpec.feature 'provider management' do
  scenario 'finding clients of a provider' do
    # client setup
    clients = %w(Sal Why Zod)
    clients.each do |name|
      visit!('/database/clients/new')
      fill_in("Name", with: name)
      fill_in("Email", with: "#{name.downcase}@example.com")

      click_button
    end

    # provider setup
    names = %w(Bob Jill Jon)
    names.each.with_index do |name, i|
      email = "#{name}@example.com"
      visit!('/database/providers/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      sub_clients = clients[0..i]
      sub_clients.each do |client|
        check(client)
      end

      click_button

      expect(current_path).to match(/providers\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
      sub_clients.each do |client|
        expect(page).to have_text(client)
      end
    end
  end
end
