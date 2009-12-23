class Review < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments, :as => :parent, :dependent => :destroy

  validates_presence_of :body, :fans_of, :tweet
  validates_length_of :tweet, :maximum => 100

  acts_as_textiled :body => [ :no_span_caps ]
  
  def truncated_body
    RedCloth.new(truncate(self.body(:source), 250)).to_html
  end
  
end
