class Book < ActiveRecord::Base
  has_many :author_books
  has_many :authors, through: :author_books
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_one :location

  accepts_nested_attributes_for :authors
  accepts_nested_attributes_for :genres

  validates :title, presence: true

  def save_associations(author, genre)
    add_authors(author)
    add_genres(genre)
  end

  private

  def add_authors(author_params)
    author_params[:authors].each do |hash|
       author = Author.find_or_create_by(first_name: hash[:first_name], last_name: hash[:last_name])
      self.authors << author
    end
  end

  def add_genres(genre_params)
    genre_params[:genres].each do |hash|
      genre = Genre.find_or_create_by(name: hash[:name])
      self.genres << genre
    end
  end
end
