require 'rails_helper'

describe Page do
  it 'have a valid factory' do
    new_page = build :page
    expect(new_page).to be_valid
  end

  it 'is invalid without a name' do
    new_page = build :page, name: nil
    new_page.valid?
    expect(new_page.errors[:name]).to include "can't be blank"
  end

  it 'is invalid with incorrect characters' do
    new_page = build :page, name: 'a~!@#$%^&*a()-+=/<>?:a'
    new_page.valid?
    expect(new_page.errors[:name]).to include 'contains invalid characters'
  end

  it 'is valid without a title' do
    new_page = build :page, title: nil
    new_page.valid?
    expect(new_page.errors[:title]).not_to include "can't be blank"
  end

  it 'is valid without a body' do
    new_page = build :page, body: nil
    new_page.valid?
    expect(new_page.errors[:body]).not_to include "can't be blank"
  end

end
