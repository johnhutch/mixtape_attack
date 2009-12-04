module ApplicationHelper
  
  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str, container = nil)
    @page_title = str
    content_tag(container, str) if container
  end
  
  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, flash[msg.to_sym], :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end
  
  def countdown_field(field_id,update_id,max,options = {})
    function = "$('#{update_id}').innerHTML = (#{max} - $F('#{field_id}').length);"
    count_field_tag(field_id,function,options)
  end
  
  def count_field(field_id,update_id,options = {})
    function = "$('#{update_id}').innerHTML = $F('#{field_id}').length;"
    count_field_tag(field_id,function,options)
  end
  
  def count_field_tag(field_id,function,options = {})  
    out = javascript_tag function
    out += observe_field(field_id, options.merge(:function => function))
    return out
  end
  
  def artist_album(album)
    "<span class=\"artist\">" + album.artist.name + "</span> - <spam class=\"album\">" + album.name + "</span>"
  end
  def other_albums(album)
    strout = "<h3>Other albums by " + album.artist.name + "</h3>\n"
    strout += "<ul id=\"otheralbums\" class=\"clearfix\">\n"
    for other in album.artist.albums
      strout += "<li>" + link_to((image_tag other.art.url(:featured), :alt => other.name), album_path(other)) + "</li>" unless album == other
    end
    strout += "</ul>"
  end
  
  def other_reviews(user)
    strout = "<h3>Reviews by " + user.name + "</h3>\n"
    strout += "<ul id=\"otherreviews\">\n"
    for other in user.reviews
      strout += "<li><h4><a href=\"/reviews/" + other.id.to_s + "\"><strong>" + other.album.artist.name + "</strong> <em>by</em> " + other.album.name + "</a></h4>"
      strout += "<p>" + other.tweet + "</p>"
      strout += "</li>"
    end
    strout += "</ul>"
  end
  
end
