class Review < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  validates_presence_of :body
  def truncated_body(length=150, truncate_string = "...")
    return if self.body.nil?
    l = length - truncate_string.chars.length
    self.body.chars.length > length ? self.body[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : self.body
  end
  
  def score
    @rating = Rating.find(:first, :conditions => ['user_id = ? and album_id = ?', self.user.id, self.album.id])
    @rating.score
  end
end
