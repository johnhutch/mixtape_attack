class Review < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  has_many :comments, :as => :parent, :dependent => :destroy

  validates_presence_of :body, :fans_of, :tweet
  validates_length_of :tweet, :maximum => 100

  acts_as_textiled :body
  
  def truncated_body
    RedCloth.new(truncate(self.body(:source), 250)).to_html
  end
  
  def score
    @rating = Rating.find(:first, :conditions => ['user_id = ? and album_id = ?', self.user.id, self.album.id])
    @rating.score
  end
  
  def decimal_score
    sprintf ("%.1f", self.score)
  end
  
end
