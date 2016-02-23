require 'rails_helper'

describe Page do
  it 'have a valid factory' do
    new_page = build :page
    expect(new_page).to be_valid
  end

  it 'is invalid without a id' do
    new_page = build :page, id: nil
    new_page.valid?
    expect(new_page.errors[:id]).to include "can't be blank"
  end

  it 'is invalid with incorrect characters in id' do
    new_page = build :page, id: 'a~!@#$%^&*a()-+=/<>?:a'
    new_page.valid?
    expect(new_page.errors[:id]).to include 'contains invalid characters'
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

  context 'when saved' do
    it 'sanitize dangerous elements' do
      page = create :page, body: '<script>alert("1");</script>'
      expect(page.html).to eq 'alert("1");'
    end
    it 'skips safe elements' do
      page = create :page, body: '<h1>head</h1><b>bold</b>'
      expect(page.html).to eq '<h1>head</h1><b>bold</b>'
    end
    it 'replace **text** to <b>text</b>' do
      page = create :page, body: '**text1** text2**текст3**'
      expect(page.html).to eq '<b>text1</b> text2<b>текст3</b>'
    end
    it 'replace \\\\text\\\\ to <i>text</i>' do
      page = create :page, body: '\\\\text1\\\\ text2\\\\текст3\\\\'
      expect(page.html).to eq '<i>text1</i> text2<i>текст3</i>'
    end
    it 'replace ((name1/name2/name3 строка)) to <a href="name1/name2/name3">строка</a>' do
      page = create :page, body: '((name1/name2/name3 строка))'
      expect(page.html).to eq '<a href="name1/name2/name3">строка</a>'
    end
  end
end
