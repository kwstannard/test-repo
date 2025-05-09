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

  scenario 'feeding a cat some cat food' do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Cat food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Meow")
    end
  end

  scenario 'feeding a cat some chicken'do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Chicken', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Meow")
    end
  end

  scenario 'feeding a cat some milk' do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Milk', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Meow")
    end
  end

  scenario 'feeding a cat some lemon' do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Lemon', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to be_empty
    end
  end

  scenario 'feeding a cat some human food' do
    visit! '/design/animal_feedings'

    select('Cat', from: 'Animal type')
    select('Human food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to be_empty
    end
  end

  scenario 'feeding a dog some dog food' do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Dog food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Bark")
    end
  end

  scenario 'feeding a dog some cat food' do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Cat food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Bark")
    end
  end

  scenario 'feeding a dog some chicken'do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Chicken', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Bark")
    end
  end

  scenario 'feeding a dog some milk' do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Milk', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to be_empty
    end
  end

  scenario 'feeding a dog some lemon' do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Lemon', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to be_empty
    end
  end

  scenario 'feeding a dog some human food' do
    visit! '/design/animal_feedings'

    select('Dog', from: 'Animal type')
    select('Human food', from: 'Food type')

    click_button
    expect(status_code).to eq(200)

    within('.stdout') do |x|
      expect(page.text).to eq("Bark")
    end
  end
end
