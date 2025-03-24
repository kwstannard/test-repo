require 'rails_helper'

RSpec.feature 'TODO list app' do
  scenario 'adding an item to the list' do
    visit!('/react/todo')
    expect(page).to have_content("ToDo")
    expect(page).to have_content("Doing")
    expect(page).to have_content("Done")
  end
end
