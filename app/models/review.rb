class Review < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  validates_presence_of :body, :fans_of, :tweet
  validates_length_of :tweet, :maximum => 100
  
  def score
    @rating = Rating.find(:first, :conditions => ['user_id = ? and album_id = ?', self.user.id, self.album.id])
    @rating.score
  end
end
