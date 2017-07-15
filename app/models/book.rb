require 'google_books'

class Book < ActiveRecord::Base
  # todo capitalize book

  has_many :author_books
  has_many :authors, through: :author_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  belongs_to :location

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :genres

  validates :title, presence: true
  validates :isbn, uniqueness: { scope: :title }

  private

end
