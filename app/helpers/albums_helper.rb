module AlbumsHelper
  def artist_album(album)
    "<span class=\"artist\">" + album.artist.name + "</span> - <spam class=\"album\">" + album.name + "</span>"
  end
end
