module MoviesHelper

  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end

  def image_url(movie)
    movie.image.url.present? ? movie.image.url : movie.poster_image_url
  end

end
