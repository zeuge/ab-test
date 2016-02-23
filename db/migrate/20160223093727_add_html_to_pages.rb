class AddHtmlToPages < ActiveRecord::Migration
  def up
    add_column :pages, :html, :text

    Page.find_each do |page|
      page.save
    end
  end

  def down
    remove_column :pages, :html
  end
end
