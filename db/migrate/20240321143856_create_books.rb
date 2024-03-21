class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn_13
      t.decimal :price
      t.integer :year_published
      t.text :image
      t.string :edition
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
