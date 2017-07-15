require 'httparty'

class GoogleBooks
  include HTTParty

  base_uri('https://www.googleapis.com')

  def initialize(title)
    full_response = self.class.get("/books/v1/volumes?q=intitle:#{title.gsub(' ', '+')}")
    @response = full_response['items']
  end

  def categories
    @response[0]['volumeInfo']['categories']
  end

  def isbn
    identifiers = @response[0]['volumeInfo']['industryIdentifiers']
    identifiers.select{ |h| h['type'] == 'ISBN_13' }[0]['identifier']
  end

  def authors
    @response[0]['volumeInfo']['authors']
  end

  def description
    @response[0]['volumeInfo']['description']
  end

  def page_count
    @response[0]['volumeInfo']['pageCount']
  end

  def thumbnail
    @response[0]['volumeInfo']['imageLinks']['thumbnail']
  end
end