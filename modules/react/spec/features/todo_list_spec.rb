require 'rails_helper'

RSpec.feature 'TODO list app' do
  scenario 'adding an item to the list' do
    visit!('/react/todo')
    expect(page).to have_content("Hello world!")
  end
end
