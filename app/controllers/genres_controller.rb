class GenresController < ApiController

  # get /genres
  def index
    @genres = Genre.all
    json_response(@genres)
  end

  # post /genres
  def create
    @genre = Genre.create!(genre_params)
    json_response(@genre)
  end

  # get /genres/:id
  def show
    json_response(@genre)
  end

  # put /genres/:id
  def update
    @genre.update(genre_params)
  end

  # delete /genres/:id
  def destroy
    @genre.destroy
  end

  private

  def genre_params
    params.permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end
