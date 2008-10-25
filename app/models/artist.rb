class Artist < ActiveRecord::Base  
  has_many :albums 
  
  validates_presence_of :name
  
  has_attached_file :photo,
              :path => ":rails_root/public/bin/:class/:attachment/:id/:style_:basename.:extension",
              :url => "/bin/:class/:attachment/:id/:style_:basename.:extension",
              :default_url => "/images/missing_:class_:style.png",
              :styles => { :show => "300x300<" }
              
end
