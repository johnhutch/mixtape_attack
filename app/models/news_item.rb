class NewsItem < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title, :body
  
  acts_as_textiled :body

end
