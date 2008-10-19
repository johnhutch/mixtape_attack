class Artist < ActiveRecord::Base  
  
  validates_presence_of :name
  has_attached_file :photo,
              :styles => { :show => "300x300>" }
              
end
