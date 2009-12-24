class NewsItem < ActiveRecord::Base
  belongs_to :user  
  has_many :comments, :as => :parent, :dependent => :destroy
  
  validates_presence_of :title, :body
  
  acts_as_textiled :body, :excerpt

end
