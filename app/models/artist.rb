class Artist < ActiveRecord::Base  
  
  has_attached_file :photo,
              :styles => { :show => "300x300>" }
end
