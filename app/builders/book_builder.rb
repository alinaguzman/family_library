require 'google_books'

class BookBuilder
  attr_reader :book

  def self.build
    builder = new
    yield(builder)
    builder.book
  end

  def initialize
    @book = Book.new
  end

  def set_title(title)
    set_google_book(title)
    @book.title = title
  end

  def set_google_book(title)
    @google_book = GoogleBooks.new(title)
    set_isbn
    add_genres
    set_description
    set_pages
    set_thumbnail
  end

  def add_authors(authors_params)
    check_authors(authors_params)
    authors_params['authors'].each do |hash|
      a = Author.find_or_create_by(first_name: hash[:first_name],
                                   last_name: hash[:last_name])
      @book.authors << a
    end
  end

  def check_authors(authors_hash)
    return unless authors_hash.keys.include? 'authors'
    lower_case = @google_book.authors.map{ |a| a.downcase }
    authors_hash['authors'].each do |hash|
      if lower_case.include? [hash['first_name'].downcase,
                              hash['last_name'].downcase].join(' ')
        return true
      end
    end
    raise 'Authors not matched'
  end

  def add_genres
    @google_book.categories.each do |g|
      genre = Genre.find_or_create_by(name: g)
      @book.genres << genre
    end
  end

  def add_location(location)
    @book.location = Location.find_or_create_by({name: location})
  end

  def book
    raise 'Not enough authors' if @book.authors.length < 1
    @book
  end

  private

  def set_isbn
    @book.isbn = @google_book.isbn
  end

  def set_pages
    @book.pages = @google_book.page_count
  end

  def set_description
    @book.description = @google_book.description
  end

  def set_thumbnail
    @book.thumbnail = @google_book.thumbnail
  end
end