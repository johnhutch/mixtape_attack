module ContentsHelper
  
  def upcoming_albums(albums)
    strout = ""
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
	end
		
end
