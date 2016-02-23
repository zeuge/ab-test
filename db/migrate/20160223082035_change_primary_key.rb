class ChangePrimaryKey < ActiveRecord::Migration
  def up
      remove_column :pages, :id
      rename_column :pages, :name, :id
      execute 'ALTER TABLE pages ADD PRIMARY KEY (id);'
    end

    def down
      execute 'ALTER TABLE pages DROP CONSTRAINT pages_pkey;'
      rename_column :pages, :id, :name
      add_column :pages, :id, :primary_key
    end
end
