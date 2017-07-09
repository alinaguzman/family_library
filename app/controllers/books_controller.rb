class BooksController < ApiController
  before_action :set_book, only: [:show, :update, :destroy]

  # get /books
  def index
    @books = Book.all
    json_response(@books)
  end

  # post /books
  def create
    @book = Book.new(book_params)
    if @book.save
      @book.save_associations(author_params, genre_params)
    end
    response = { :book => @book }.to_json(:include => [:authors, :genres])
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
    params.require(:book).permit(:title)
  end

  def author_params
    params.require(:book).permit({ authors: [:first_name, :last_name]})
  end

  def genre_params
    params.require(:book).permit({ genres: [:name]})
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
