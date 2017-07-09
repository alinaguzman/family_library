class AuthorsController < ApiController
  before_action :set_author, only: [:show, :update, :destroy]

  # get /authors
  def index
    @authors = Author.all
    json_response(@authors)
  end

  # post /authors
  def create
    @author = Author.create!(author_params)
    json_response(@author, :created)
  end

  # get /authors/:id
  def show
    json_response(@author)
  end

  # put /authors/:id
  def update
    @author.update(author_params)
  end

  # delete /authors/:id
  def destroy
    @author.destroy
  end

  private

  def author_params
    params.permit(:name)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
