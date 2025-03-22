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

    # add relationships and check that they are visible
    clients.each.with_index do |client, i|
      visit!('/database/clients')

      click_on(client)

      click_on('Edit')

      sub_providers = providers[0..i]
      sub_providers.each do |provider|
        check(provider)
      end

      click_button

      expect(current_path).to match(/clients\/\d+\z/)

      providers[i+1..-1].each do |unchecked_provider|
        expect(page).to_not have_text(unchecked_provider)
      end

      # Check that all subproviders exist
      sub_providers.each do |provider|
        click_on provider
        expect(current_path).to match(/clients\/\d+\/providers\/\d+\z/)
        click_on client
      end

      # run through premium functionality
      premium_provider = sub_providers.first
      click_on premium_provider
      expect(current_path).to match(/clients\/\d+\/providers\/\d+\z/)
      click_on 'Make Premium'
      click_on client
      within("##{premium_provider}") { expect(page).to have_text("Premium") }

      click_on premium_provider
      click_on 'Make Basic'
      click_on client
      within("##{premium_provider}") { expect(page).to have_text("Basic") }
    end
  end
end
