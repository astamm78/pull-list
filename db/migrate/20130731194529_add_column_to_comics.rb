class AddColumnToComics < ActiveRecord::Migration
  def change
    add_column :comics, :obtained, :boolean, :default => false
  end
end
