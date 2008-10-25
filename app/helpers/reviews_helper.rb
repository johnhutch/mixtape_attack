module ReviewsHelper
  
  def other_albums(album)
    strout = "<h3>Albums by " + album.artist.name + "</h3>\n"
    strout += "<ul id=\"otheralbums\">\n"
    for other in album.artist.albums
      strout += "<li>" + link_to (other.name, album_path(other)) + "</li>" unless album == other
    end
    strout += "</ul>"
  end
  
  def other_reviews(user)
    strout = "<h3>Reviews by " + user.name + "</h3>\n"
    strout += "<ul id=\"otherreviews\">\n"
    for other in user.reviews
      strout += "<li>" + link_to (other.album.name, review_path(other)) + "</li>"
    end
    strout += "</ul>"
  end
end
