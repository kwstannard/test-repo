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
    providers = %w(Bob Jill Jon)
    providers.each.with_index do |name|
      email = "#{name}@localhost".downcase

      visit!('/database/providers/new')
      fill_in("Name", with: name)
      fill_in("Email", with: email)

      click_button

      expect(current_path).to match(/providers\/\d+\z/)
      expect(page).to have_text(name)
      expect(page).to have_text(email)
    end

    clients.each.with_index do |name, i|
      visit!('/database/clients')

      click_on(name)

      click_on('Edit')

      sub_providers = providers[0...i]
      sub_providers.each do |provider|
        check(provider)
      end

      click_button

      expect(current_path).to match(/clients\/\d+\z/)
      sub_providers.each do |provider|
        expect(page).to have_text(provider)
      end
    end
  end
end
