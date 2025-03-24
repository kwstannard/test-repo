require 'rails_helper'

RSpec.feature 'TODO list app' do
  scenario 'adding an item to the list' do
    page.driver.with_playwright_page {|p|
      logs = []
      errors = []
      p.on('console', ->(msg) { logs << msg })
      p.on('weberror', ->(msg) { errors << msg })

      visit!('/react/todo')
      expect(page).to have_content("ToDo")
      expect(page).to have_content("Doing")
      expect(page).to have_content("Done")

      # add items
      fill_in("Text", with: "Do the dishes")
      click_button
      within("#ToDo") { expect(page).to have_content("Do the dishes") }

      fill_in("Text", with: "Wash the car")
      click_button
      within("#ToDo") { expect(page).to have_content("Wash the car") }

      fill_in("Text", with: "Feed the cat")
      click_button
      within("#ToDo") { expect(page).to have_content("Feed the cat") }

      # moving items across lists
      find("li", text: "Do the dishes")
        .drag_to(find("#Doing"))
      within("#Doing") { expect(page).to have_content("Do the dishes") }
      within("#ToDo") { expect(page).to_not have_content("Do the dishes") }
    }
  end
end
