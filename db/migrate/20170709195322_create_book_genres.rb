class CreateBookGenres < ActiveRecord::Migration
  def change
    create_table :book_genres do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
