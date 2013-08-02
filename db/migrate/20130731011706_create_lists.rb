class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :date
      t.timestamps
    end
  end
end
