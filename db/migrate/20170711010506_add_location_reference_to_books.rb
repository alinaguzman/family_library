class AddLocationReferenceToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :location, index: true, foreign_key: true
  end
end
