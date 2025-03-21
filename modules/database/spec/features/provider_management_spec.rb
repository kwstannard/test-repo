require 'rails_helper'

RSpec.feature 'provider management' do
  scenario 'finding clients of a provider' do
    # client setup
    clients = %w(BigCo LittleCo MediumCo)
    clients.each do |name|
      visit!('/database/clients/new')
      fill_in("Name", with: name)
      fill_in("Email", with: "#{name.downcase}@example.com")
      select("Premium")
      click_button
    end
  end
end
