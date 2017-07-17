
class BooksController < ApiController
  before_action :set_book, only: [:show, :update, :destroy]

  # get /books
  def index
    @books = Book.all
    json_response(@books)
  end

  # post /books
  def create
    book = BookBuilder.build do |builder|
      builder.set_title(book_params[:title])
      builder.add_authors(authors_params)
      builder.add_location(book_params[:location])
    end
    unless book.save
      book = Book.where({ title: book_params[:title] }).first
      # puts book.errors.messages.inspect
    end
    response = { :book => book }.to_json(:include => [:authors, :genres])
    json_response(response)
  end

  # get /books/:id
  def show
    json_response(@book)
  end

  # put /books/:id
  def update
    @book.update(book_params)
  end

  # delete /books/:id
  def destroy
    @book.destroy
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :location)
  end

  def authors_params
    params.require(:book).permit({ authors: [:first_name, :last_name]})
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
