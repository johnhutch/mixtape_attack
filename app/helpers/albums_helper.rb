module AlbumsHelper
  def artist_album(album)
    "<span class=\"artist\">" + album.artist.name + "</span> - <spam class=\"album\">" + album.name + "</span>"
  end
  
  def other_albums(album)
    strout = "<h3>Other albums by " + album.artist.name + "</h3>\n"
    strout += "<ul id=\"otheralbums\">\n"
    for other in album.artist.albums
      strout += "<li>" + link_to (other.name, album_path(other)) + "</li>" unless album == other
    end
    strout += "</ul>"
  end
end
