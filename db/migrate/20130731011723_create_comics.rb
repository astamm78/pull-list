class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :title
      t.integer :list_id
      t.boolean :purchase
      t.boolean :download
      t.timestamps
    end
  end
end
