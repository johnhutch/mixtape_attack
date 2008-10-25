class Artist < ActiveRecord::Base  
  
  validates_presence_of :name
  has_attached_file :photo,
              :path => ":rails_root/public/bin/:class/:attachment/:id/:style_:basename.:extension",
              :url => "/bin/:class/:attachment/:id/:style_:basename.:extension",
              :styles => { :show => "300x300<" }
              
end
