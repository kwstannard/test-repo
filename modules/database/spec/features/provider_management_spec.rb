require 'rails_helper'

RSpec.feature 'Client management' do
  scenario 'creating clients, providers, and associating them' do
    clients = %w(Sal Why Zod)
    clients.each {|x| create_client(x) }

    providers = %w(Bob Jill Jon)
    providers.each {|x| create_provider(x) }

    # add relationships and check that they are visible
    clients.each.with_index do |client, i|
      sub_providers = providers[0..i]
      associate_client_to_providers(client, sub_providers)
    end
  end

  scenario 'changing the plan' do
    provider = "Bob".tap {|x| create_provider(x) }
    client = "Steven".tap {|x| create_client(x) }
    associate_client_to_providers(client, [provider])

    visit("/database/clients")
    click_on client

    click_on provider
    expect(current_path).to match(/clients\/\d+\/providers\/\d+\z/)
    click_on 'Make Premium'
    click_on client
    within("##{provider}") { expect(page).to have_text("Premium") }

    click_on provider
    click_on 'Make Basic'
    click_on client
    within("##{provider}") { expect(page).to have_text("Basic") }
  end

  def create_client(name)
    email = "#{name}@localhost".downcase

    visit!('/database/clients/new')
    fill_in("Name", with: name)
    fill_in("Email", with: email)

    click_button

    expect(current_path).to match(/clients\/\d+\z/)
    expect(page).to have_text(name)
    expect(page).to have_text(email)
  end

  def create_provider(name)
    email = "#{name}@localhost".downcase

    visit!('/database/providers/new')
    fill_in("Name", with: name)
    fill_in("Email", with: email)

    click_button

    expect(current_path).to match(/providers\/\d+\z/)
    expect(page).to have_text(name)
    expect(page).to have_text(email)
  end

  def associate_client_to_providers(client, sub_providers)
    visit!('/database/clients')

    click_on(client)

    click_on('Edit')

    sub_providers.each do |provider|
      check(provider)
    end

    click_button

    expect(current_path).to match(/clients\/\d+\z/)

    expect(table_hash.tap{|x| binding.irb}.map{|row| row['Name']}.sort).to eq(sub_providers.sort)

    # Check that all subproviders are visible
    sub_providers.each do |provider|
      click_on provider
      expect(current_path).to match(/clients\/\d+\/providers\/\d+\z/)
      click_on client
    end
  end
end
