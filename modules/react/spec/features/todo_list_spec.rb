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
      click_button("Submit")
      fill_in("Text", with: "Wash the car")
      click_button("Submit")
      fill_in("Text", with: "Feed the cat")
      click_button("Submit")

      within("#ToDo") { expect(page.text).to eq(<<~DOC.chomp) }
        ToDo
        Do the dishes
        Wash the car
        Feed the cat
      DOC

      # moving items across lists
      find(".item", text: "Do the dishes")
        .drag_to(find("#Doing > h1"))
      within("#Doing") { expect(page).to have_content("Do the dishes") }
      within("#ToDo") { expect(page).to_not have_content("Do the dishes") }

      find(".item", text: "Do the dishes")
        .drag_to(find("#ToDo > h1"))
      within("#Doing") { expect(page).to_not have_content("Do the dishes") }
      within("#ToDo") { expect(page).to have_content("Do the dishes") }

      # moving items around a list
      within("#ToDo") { expect(page.text).to eq(<<~DOC.chomp) }
        ToDo
        Wash the car
        Feed the cat
        Do the dishes
      DOC

      find(".item", text: "Do the dishes")
        .drag_to(find(".item", text: "Feed the cat"))

      within("#ToDo") { expect(page.text).to eq(<<~DOC.chomp) }
        ToDo
        Wash the car
        Do the dishes
        Feed the cat
      DOC

      find(".item", text: "Do the dishes")
        .drag_to(find(".item", text: "Wash the car"))

      within("#ToDo") { expect(page.text).to eq(<<~DOC.chomp) }
        ToDo
        Do the dishes
        Wash the car
        Feed the cat
      DOC

      # Done pizzazz

      find(".item", text: "Do the dishes")
        .drag_to(find("#Done"))
    }
  end
end
