require 'rails_helper'

RSpec.feature 'Animal feeding' do
  scenario 'feeding a cat some dog food' do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Dog food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to be_empty
    end
  end

  scenario 'feeding a cat some cat food'
  scenario 'feeding a cat some chicken'
  scenario 'feeding a cat some milk'
  scenario 'feeding a cat some lemon'
  scenario 'feeding a cat some human food'

  scenario 'feeding a dog some dog food'
  scenario 'feeding a dog some cat food'
  scenario 'feeding a dog some chicken'
  scenario 'feeding a dog some milk'
  scenario 'feeding a dog some lemon'
  scenario 'feeding a dog some human food'
end
