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
  
  def upcoming_albums(albums)
    strout = "<h3>Upcoming Releases</h3>"
  	strout += "<dl id=\"front_calendar\">"
  		@release_days = @albums.group_by { |a| a.release_date.beginning_of_day } unless @albums.nil?
  		unless @release_days.nil?
  			@release_days.keys.sort.each do |day|
  				strout += "<dt>" + day.strftime('%B %e') + "</dt>"
  				for album in @release_days[day]
  					strout += "<dd>" + link_to(artist_album(album), album_path(album))
  					strout += " on " + link_to(album.label.name, label_path(album.label)) unless album.label.nil? 
  					strout += "</dd>"
  				end
  			end
  		end
  	strout += "</dl>"
  	strout += "<h4><a href=\"/albums/calendar\">More &gt;</a></h4>"
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
end
