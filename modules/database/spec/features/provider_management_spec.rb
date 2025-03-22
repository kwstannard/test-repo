require 'rails_helper'

RSpec.feature 'provider management' do
  scenario 'finding clients of a provider' do
    # client setup
    clients = %w(Sal Why Zod)
    clients.each do |name|
      email = "#{name}@localhost".downcase

      visit!('/database/clients/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      click_button

      expect(current_path).to match(/clients\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
    end

    # provider setup
    names = %w(Bob Jill Jon)
    names.each.with_index do |name, i|
      email = "#{name}@localhost".downcase

      visit!('/database/providers/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      click_button

      expect(current_path).to match(/providers\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
    end
  end
end
