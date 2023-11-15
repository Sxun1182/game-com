class Admin::GenresController < ApplicationController
  def create
    Genre.create(genre_params)
    redirect_to admin_genres_path
  end
  
  def index
    @genres = Genre.all
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end