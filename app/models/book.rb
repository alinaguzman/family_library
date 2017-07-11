require 'google_books'

class Book < ActiveRecord::Base
  before_save :set_google_book
  before_save :validate_author
  before_create :validate_isbn

  has_many :author_books
  has_many :authors, through: :author_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_one :location

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :genres

  validates :title, presence: true

  attr_accessor :author_list

  def set_google_book
    @google_book = GoogleBooks.new(title)
  end

  def validate_author
    return true if author_list.empty?
    check_authors
  end

  private

  def validate_isbn
    self.isbn = @google_book.isbn
    book = Book.where({ title: self.title, isbn: self.isbn}).first
    book ? false : true
  end

  def check_authors
    match = false
    lower_case = @google_book.authors.map{ |a| a.downcase }
    author_list['authors'].each do |hash|
      if lower_case.include? [hash['first_name'].downcase, hash['last_name'].downcase].join(' ')
        match = true
      end
    end
   match ? add_authors : false
  end

  def add_authors
    author_list['authors'].each do |hash|
       a = Author.find_or_create_by(first_name: hash[:first_name], last_name: hash[:last_name])
      self.authors << a
    end
  end

  def add_genres(genre_params)
    genre_params[:genres].each do |hash|
      genre = Genre.find_or_create_by(name: hash[:name])
      self.genres << genre
    end
  end
end
